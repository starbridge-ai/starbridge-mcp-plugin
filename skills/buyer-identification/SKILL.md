---
name: buyer-identification
user-invocable: false
description: Identify which buyer (institution) the user is asking about by searching the buyer database. Use as the first step whenever a question involves a specific institution, school, district, agency, or organization.
---

# Buyer Identification

Identifies which buyer (institution) the user is asking about. Use it as the first step whenever the user's question involves a specific institution, school, district, agency, or organization.

## When to Use
- The user mentions an institution by name (full, partial, or colloquial)
- The user references an institution indirectly ("how much have they purchased", "what about them")
- Any query that requires knowing which buyer to look up data for

## Tool: `searchBuyers`
Searches the buyer database and returns the top matches. Use a single search with the best inferred buyer name — the tool handles fuzzy matching for partial or misspelled names. If the user mentions a state or province, set `buyerStateCode` to the standardized ISO 3166-2 state code.

## Workflow
1. Extract the buyer/institution name from the user's message
2. Call `searchBuyers` with `buyerName` (and `buyerStateCode` when stated)
3. Evaluate the returned candidates and select the best match
4. Retain the buyer's `id`, `name`, `url`, and `stateCode` for subsequent tool calls
5. If no confident match exists, ask the user to clarify which institution they mean

## Example Clarification Response
> "I found multiple institutions matching that name. Could you clarify which one you mean?"
