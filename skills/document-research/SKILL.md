---
name: document-research
user-invocable: false
description: "Search a buyer's internal documents — RFPs, board-meeting minutes, strategic plans, procurement records, contracts, and line items — plus buyer-scoped web sources, for detailed, evidence-backed answers."
when_to_use: "Use for history, vendors, technology, contracts, spend detail, and anything needing document evidence rather than a standardized score. Example triggers — 'what have they purchased', 'what vendors do they use', 'find their RFPs', 'what did the board discuss about X', 'do they have a contract with Y', 'what is in their strategic plan'. Use buyer-attributes instead for a single pre-computed metric, and buyer-summary for a high-level narrative. Run buyer-identification first if the buyer id is unknown."
---

# Document Research

Searches internal documents and public web sources for information about a buyer. Provides access to RFPs, board meeting minutes, strategic plans, procurement records, contracts, and buyer-scoped web research.

## When to Use
- Questions about what a buyer has discussed, planned, or decided
- Historical information, meeting minutes, or strategic plans
- Procurement history, contracts, or purchase details
- Research questions requiring document analysis
- Questions that can't be answered with structured attributes alone

## Tools

### `researchBuyerFiles`
Searches internal documents (RFPs, board meetings, procurement data). Returns matching files with summaries and highlights. Procurement records are typically the most reliable source for vendors, technology, and contracts.

### `viewFileContents`
Retrieves full contents of a specific file. Use when summaries aren't sufficient for accurate answers (comparisons, exact quotes, specific numbers).

### `getOpportunityLineItems`
Retrieves line items from contracts or purchase orders. Pass the `opportunityId` (not the file id).

### `runBuyerWebResearch`
Returns buyer-scoped web search results as source candidates (URL, title, excerpts) for citation-driven research. Use as a supplement when internal documents don't fully answer the question.

## Workflow
1. For factual questions (vendors, technology, contracts), start with `researchBuyerFiles` — procurement records are the most reliable source
2. Run `runBuyerWebResearch` in parallel or as a supplement
3. Review summaries and highlights from search results
4. Use `viewFileContents` or `getOpportunityLineItems` when full details are needed
5. Synthesize findings into a comprehensive answer

## If Initial Search Yields No Results
Do NOT give up after one search attempt. Try:
1. Different keywords (synonyms, abbreviations, full names)
2. The other search tool if you only used one
3. Broader search terms, then narrow down
4. Different document types (board meetings often discuss technology decisions)

Only respond with "no information found" after exhausting multiple search strategies.

## Document Type Selection

| Query Type | Primary Sources | Examples |
|------------|-----------------|----------|
| Strategic / Discussion | Board meetings, strategic plans | "plans for", "discussed", "strategy" |
| Procurement / Usage | Procurement data | "purchased", "licenses", "spending" |
| Recent / Time-based | All types | "recent", "latest", "this year" |

## Recency and date filters

"Recent" means something different for each document type, and the date-filter inputs on `researchBuyerFilesPrivate` (`effectiveDateGte` / `effectiveDateLte`) and sort fields (`OpportunityFromDate`, `OpportunityUntilDate`) map to *different underlying dates* depending on the type:

- **Meetings / strategic plans:** "from date" = when the document was posted; "until date" is not meaningful.
- **RFPs:** "from date" = posted date; "until date" = due date.
- **Procurement (POs and contracts):** "from date" = effective date; "until date" = expiration / end date.

Because one filter parameter spans all three, the same numeric threshold means different things across types. Do not apply one date filter across mixed types in a single call.

When the user's question implies recency, use these starting defaults — adjust if the initial search returns nothing or the user asked for historical context:

| User asks about | `opportunityTypes` | Default filter / sort |
|---|---|---|
| Meetings, strategic plans, "what did they discuss / decide / plan" | `BoardMeeting_StrategicPlan` | `effectiveDateGte` ≈ 1 year ago; sort `OpportunityFromDate DESC` |
| RFPs — active, open, or recent | `RequestForProposals` | sort `OpportunityUntilDate DESC`; no date filter. Results include both future-due and recently-expired RFPs — distinguish them in your answer by comparing each `OpportunityUntilDate` to today's date |
| Current / active vendor contracts | `ProcurementData` | sort `OpportunityUntilDate DESC` to surface contracts ending furthest in the future. **Do not** filter by `effectiveDateGte` — multi-year contracts signed years ago may still be active |
| Recent purchases, spending, procurement activity | `ProcurementData` | `effectiveDateGte` ≈ 2 years ago; sort `OpportunityFromDate DESC` |

Defaults are a starting point, not a hard rule. Widen or drop the filter if the search returns too little, the user explicitly asks for historical context, or you have reason to believe the relevant document is older (e.g. a 5-year strategic plan, a long-running contract).

### Always disclose the time window you searched

Whenever a date filter was applied — including one you chose yourself without being asked — tell the user the time window the search covered. One line at the end of your answer is enough, e.g.:

- "(searched meetings posted in the last 12 months)"
- "(searched purchases with effective dates in the last 2 years — older long-running contracts may not appear)"

It's fine to default to a recent window when the user asks for "recent" content; it's not fine to filter silently and present the result as exhaustive. Surfacing the window lets the user re-prompt if the answer they want falls outside it.

## When to View Full File Contents
- Comparisons or rankings across documents (largest, most recent, etc.)
- Specific quotes, numbers, or detailed specifications
- When summaries don't provide enough certainty to answer

## Tips
- Search both abbreviated and full forms of acronyms (e.g., "FERPA" and "Family Educational Rights and Privacy Act")
- Try refined keywords if initial search doesn't yield relevant results
- Use readable file names in responses, not UUIDs
