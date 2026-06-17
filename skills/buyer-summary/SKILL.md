---
name: buyer-summary
description: Summarize a buyer's tracked activity into current priorities, momentum, risks, opportunities, and outreach-ready context grounded in Starbridge data. Use for strategy, talking points, call prep, and "what do we know" questions.
---

# Buyer Summary

Retrieves a buyer summary synthesized from tracked buyer activity and available signals. It is the fastest way to understand the buyer's current strategy, momentum, risks, open questions, and where to focus outreach.

## When to Use
- The user wants to know the buyer's strategy or top priorities
- The user asks for talking points, email angles, call preparation, or other outreach
- The user asks what information we have about a buyer across the data we've collected
- The user explicitly asks for the buyer summary

## Tool: `getBuyerSummary`
Returns a structured summary grounded in tracked account activity and available signals. The summary is optimized for recent developments, the bigger strategic picture, and the best areas for deeper discovery. Requires `organizationId` and `buyerId` path parameters. If the tool fails or returns no usable summary, continue with `document-research` instead of stopping.

## Workflow
1. Ensure the buyer has been identified first via `buyer-identification`
2. Call `getBuyerSummary` with the buyer id (and the current organization id)
3. Use the summary as the default grounding layer for strategy, buyer priorities, and outreach prep
4. If the tool fails, returns no usable summary, or the user needs underlying evidence, exact procurement details, or deeper verification, activate `document-research`
5. If the user wants drafted outreach, use the summary to shape the message before invoking an outbound email skill

## Important
- Treat the summary as a synthesis of tracked activity and signals, not as permission to invent details beyond it
- Prefer this skill before `document-research` for strategy or outreach questions
- If `getBuyerSummary` fails, do not stop the workflow — continue with `document-research`
- Use the summary's sections directly: recent developments, bigger picture, and areas for deeper discovery
