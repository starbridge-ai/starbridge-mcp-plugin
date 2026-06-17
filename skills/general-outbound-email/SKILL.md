---
name: general-outbound-email
description: Draft a personalized B2B outbound email for a Business Development Representative. Use whenever the user asks to generate, draft, or write an outbound email. Activate `contact-search` first to identify the recipients.
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

## Email Crafting Instructions

Write a short outbound email (under 150 words) that:
1. Opens with a personalized first line that shows you've done your homework — do NOT use a generic opener like "I hope this finds you well"
2. Leverages a specific pain or business outcome the prospect likely cares about based on the organization's business context
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
