---
name: buyer-attributes
user-invocable: false
description: "Look up pre-computed, structured scores and metrics for an identified buyer — AI-adoption, startup-friendliness, propensity-to-spend, and procurement-difficulty scores; operating budget, IT spend, population or enrollment; and for education buyers the SIS, LMS, and CRM systems."
when_to_use: "Use for a quick lookup of one standardized data point about a buyer. Example triggers — 'what is their AI adoption score', 'how big is their budget', 'what SIS does this district use', 'are they startup friendly', 'how hard are they to sell to'. Choose this over document-research when the answer is one of these standardized fields. For a narrative 'what do we know / what are their priorities' overview use buyer-summary; for evidence from RFPs, contracts, or meeting minutes use document-research. Run buyer-identification first if the buyer id is unknown."
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

## Tool: `getBuyerAttribute`
Returns the requested structured attribute for a buyer. Requires the buyer's id (from `buyer-identification`) and a `buyerAttribute` key from the `BuyerField` enum. The tool description enumerates every supported attribute key and what it returns — consult that list when picking the key.

## Workflow
1. Ensure the buyer has been identified first (use `buyer-identification`)
2. Call `getBuyerAttribute` with the `buyerId` (path) and `buyerAttribute` (path) for the metric the user is asking about
3. If the attribute returns null/empty, the data is not available — fall back to `document-research` to search the underlying documents
