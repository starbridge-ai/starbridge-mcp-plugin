---
name: contact-search
user-invocable: false
description: Find contacts at an institution (staff, executives, board members, department heads). Use for "who is" or "find contacts at" questions, and as the prerequisite step before drafting outbound email.
---

# Contact Search

Finds contacts (people) associated with a buyer institution. Searches Starbridge's verified contact database, which contains staff, executives, board members, and department heads. Falls back to public web research when no verified contact is available.

## When to Use
- Questions about who works at an institution
- Finding decision-makers, executives, or specific roles
- Looking up department heads or board members
- Any "who is..." or "find me contacts at..." query
- As a prerequisite for drafting outbound email

## Tools

### `searchBuyerContacts`
Searches the Starbridge-verified contact database. Returns contacts with verified information including name, title, department, email, and phone. Filter by canonical job titles via `include` (one or more) and optionally `exclude`. Pass titles as distinct canonical roles — not synonyms or abbreviations of the same role.

### `runBuyerWebResearch`
Buyer-scoped public web search. Use only when verified contacts are unavailable AND the user has approved searching public sources.

## Workflow
1. Ensure the buyer has been identified first via `buyer-identification`
2. Search using `searchBuyerContacts` with one or more canonical job titles in `include`
3. Present contacts using the structured output format below
4. If no verified contacts are returned, ask the user before using `runBuyerWebResearch`:
   > "I didn't find verified contacts for this role. Would you like me to search public web sources? Note that web results may be less reliable."

## Output Format
- When showing contacts, output them inside a fenced markdown block whose info string is exactly `block:contacts`
- The contents of the block must be a JSON array
- Each contact object must include exactly these fields: `firstName`, `lastName`, `middleName`, `salutation`, `title`, `email`, `phone`, `isVerified`
- Use `null` for missing values instead of omitting fields
- Do not include a `name` field in the output block
- The `block:contacts` block is the canonical contact payload for the frontend modal
- Contacts must only be shown inside `block:contacts`, never repeated outside the block as free text, bullets, headings, summaries, or card-style rows
- You may include a brief natural-language introduction or follow-up, but it must not mention any specific contact details outside the block

Example:
```block:contacts
[{"firstName":"Emily","lastName":"Johnson","middleName":"Claire","salutation":"Ms.","title":"Director of Institutional Research","email":"emily.johnson@hccc.edu","phone":"+1-201-555-0142","isVerified":true},{"firstName":"Michael","lastName":"Rivera","middleName":"Luis","salutation":null,"title":"Associate Vice President of Academic Affairs","email":"michael.rivera@hccc.edu","phone":null,"isVerified":false}]
```

## Verified vs. Unverified Contacts
- **Starbridge-verified contacts**: From `searchBuyerContacts`. Reliable and up-to-date. Set `isVerified` to `true` in the output block.
- **Web contacts**: From `runBuyerWebResearch`. May be outdated or inaccurate. Use the same `block:contacts` format and set `isVerified` to `false`.

## Important
- Never fabricate or guess contact information
- Always distinguish between verified and unverified sources via the `isVerified` field
- Users can create a contact verification bridge in the application if they need ongoing contact monitoring
