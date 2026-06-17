---
name: buyer-attributes
user-invocable: false
description: "Look up pre-computed, structured scores and metrics for an identified buyer — AI-adoption, startup-friendliness, propensity-to-spend, and procurement-difficulty scores; operating budget, IT spend, population or enrollment; and for education buyers the SIS, LMS, and CRM systems."
when_to_use: "Use for a quick lookup of one or more standardized data points about a buyer. Example triggers — 'what is their AI adoption score', 'how big is their budget', 'what SIS does this district use', 'are they startup friendly', 'how hard are they to sell to'. Choose this over document-research when the answer is one of these standardized fields. For a narrative 'what do we know / what are their priorities' overview use buyer-summary; for evidence from RFPs, contracts, or meeting minutes use document-research. Run buyer-identification first if the buyer id is unknown."
---

# Buyer Attributes

Retrieves **pre-computed scores and metrics** about a buyer. Use it for quick lookups of standardized data points before reaching for document research.

## Available Data

### Scores & Ratings (all buyer types)
- **AI Adoption Score** (1-100) and summary
- **Startup Friendliness Score** (1-100) and summary
- **Propensity to Spend Score** and summary
- **Procurement Difficulty Score** (1-100) and summary

### Budget & Size
- Operating budget amount, IT spend, budget URL
- Population (cities/counties) or enrollment (education)

### Education Buyers Only
- SIS (Student Information System) — e.g., PowerSchool, Infinite Campus
- LMS (Learning Management System) — e.g., Canvas, Blackboard
- Higher Ed CRMs, scheduling systems

## Tool: `getBuyerAttributesBulk`
Returns one or more structured attributes for a buyer in a single call. Requires the buyer's id (from `buyer-identification`) and one or more `attribute` keys from the `BuyerField` enum; the tool description enumerates every supported key and what it returns — consult that list when picking keys. Prefer this over the single-attribute `getBuyerAttribute` (whose own description recommends the bulk endpoint): one bulk call avoids the token overhead of looping per field. The response maps each requested key to its value (null when the attribute is unset). Omitting `attribute` entirely returns every available attribute — only do that for an explicit full-set need (e.g. CRM enrichment or data analysis), not for an open-ended "what do we know / how should I approach them" question, which is `buyer-summary`'s job.

## Workflow
1. Ensure the buyer has been identified first (use `buyer-identification`)
2. Call `getBuyerAttributesBulk` with the `buyerId` and the `attribute` key(s) for the metric(s) the user is asking about — request several at once rather than looping a single-attribute call per field
3. If a requested attribute comes back null/empty, that data is not available — fall back to `document-research` to search the underlying documents
