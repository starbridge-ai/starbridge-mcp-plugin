---
name: buyer-attributes
description: Retrieve pre-computed scores and metrics about a buyer (AI adoption, startup friendliness, propensity to spend, procurement difficulty, budget, enrollment). For education buyers also covers SIS/LMS systems.
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
