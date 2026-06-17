---
name: general-outbound-email
user-invocable: false
description: "Draft a personalized, concise B2B cold-outbound email for a BDR, grounded in real buyer and contact data."
when_to_use: "Use whenever the user asks to write, draft, generate, compose, or rewrite outbound email or cold outreach to a buyer. Example triggers — 'draft an email to X', 'write a cold email to the CIO', 'generate outreach for this district', 'compose a follow-up to them'. Activate contact-search first to find recipients, and buyer-identification before that if the buyer id is unknown."
---

# Outbound Email Generation

Draft a concise, compelling cold outreach email for a Business Development Representative (BDR). The email must be personalized to the buyer and grounded in real recipient data.

## Prerequisites — Find the Recipients

Before drafting the email you MUST identify who it should be sent to:
1. If you have NOT already activated `contact-search` in this conversation, activate it now and search for contacts at the target buyer.
   - If a particular contact was named, prioritize that contact. If the search fails to surface them, treat the recipient as not found.
2. Include ALL key contacts that have an email address in the `to` array. Do not limit to a single recipient — every contact returned with a valid email should be added.
3. If a particular recipient was asked for by the user, use their contact details to personalize the greeting and body if that contact has an email.
4. If contact search returns no results or no contacts have an email address, set `to` to an empty array `[]` and use a generic greeting ("Hi there" or "Hi [Title]"). Tell the user you could not find a verified contact and they should fill in the recipient manually.
5. Only include UNLOCKED contacts in the `to` array — locked contacts usually have a null email and are gated behind the credit-spending `unlockBuyerContact` tool. If the contacts you need are locked and the search response includes `unlockCreditSpendHints`, do NOT auto-unlock: tell the user the contact is locked, state the per-contact cost and remaining balance, and ask them to confirm before unlocking (see `contact-search` for the unlock flow). Draft with a generic greeting meanwhile.

## Ground the Personalization

Before drafting, make sure you actually have buyer context to personalize with — the opener and the pain/outcome must come from real data, not guesses:
- If real buyer context (priorities, momentum, outreach angles) isn't already in this conversation, activate `buyer-summary`; for recency-driven outreach, activate `buyer-signals` for a dated hook.
- Build the opening line and the pain/outcome from a specific item in that data and reference it concretely.
- If neither returns usable context, fall back to title-based relevance and tell the user the email is only lightly personalized.

## Email Crafting Instructions

Write a short outbound email (under 150 words) that:
1. Opens with a personalized first line that shows you've done your homework — do NOT use a generic opener like "I hope this finds you well"
2. Leverages a specific pain or business outcome the prospect likely cares about, grounded in the buyer context surfaced by `buyer-summary` / `buyer-signals` (or, if unavailable, the recipient's role)
3. Introduces your solution in one sentence, leading with value — not features
4. Closes with a low-friction CTA that feels like an easy "yes"
5. Uses the user's full name in the signature when available; otherwise leave a placeholder
6. Uses a conversational, human tone — no buzzwords, no fluff
7. NEVER uses em dashes in the email
8. When mentioning competitors, keeps the tone soft. Frame as "saw you're using XYZ — what teams that use XYZ tell us is..."

## Output Format

Output a JSON object inside a fenced markdown block with info string `block:email`. The JSON must have these fields:
- `to` — array of ALL key contacts that have an email address, each with `firstName` (string|null), `lastName` (string|null), `title` (string|null), `email` (string), `contactNumber` (string|null), `isVerified` (boolean). Use data from contact-search results. Use `null` for missing values. Omit contacts that do not have an email address. If no contacts were found or none have an email, use an empty array `[]`.
- `subject` — the email subject line (string)
- `body` — the full email body (string)

Example with found contacts:
```block:email
{"to":[{"firstName":"John","lastName":"Smith","title":"Chief Information Officer","email":"john.smith@example.edu","contactNumber":"+1-555-123-4567","isVerified":true},{"firstName":"Jane","lastName":"Doe","title":"VP of Operations","email":"jane.doe@example.edu","contactNumber":null,"isVerified":false}],"subject":"Streamlining your campus scheduling","body":"Hi John, I noticed your team is expanding course offerings next semester..."}
```

Example with no contact found:
```block:email
{"to":[],"subject":"Quick question about scheduling","body":"Hi there, I noticed your district is expanding..."}
```

The `block:email` block MUST be the very last thing in your response. Do not add any text, commentary, summaries, breakdowns, or explanations after it.
