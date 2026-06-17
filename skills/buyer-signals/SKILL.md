---
name: buyer-signals
user-invocable: false
description: "Surface recent buying signals — for one buyer ('what's new about X') or across all the buyers a user follows ('daily leads / morning triage') — from Starbridge's tracked feed, as dated evidence, before reaching for the web."
when_to_use: "Use for recency and 'what's happening' questions answered from the Starbridge signal feed. Per-buyer triggers (a buyer is named) — 'what's new about <X>', 'any recent activity or signals at <X>', 'what's going on with them lately', 'recent news on <district>'. Cross-buyer triggers (no single buyer) — 'daily leads', 'what's new across my accounts', 'top signals this week', 'what should I work today', 'morning triage'. For a synthesized strategic narrative use buyer-summary; for the documents behind a signal use document-research. Run buyer-identification first when a buyer is named and its id is unknown."
---

# Buyer Signals

Pulls recent buying signals from Starbridge's tracked feed. Signals are **raw, dated evidence items** (RFCs/RFPs, board discussions, budget mentions, contract milestones, leadership changes, etc.) — distinct from `buyer-summary`, which is a synthesized strategic narrative. Lead with signals for "what's new / recent"; use `buyer-summary` for "what are their priorities / how should I approach them."

## When to Use
- "What's new / recent" about a specific buyer
- A cross-buyer daily/weekly triage of fresh activity across followed accounts
- Surfacing dated evidence before (or instead of) web research

## Tools

### `listRecentBuyerSignals` (per-buyer)
Recent signals for a **single** buyer (requires the buyer id). Defaults to roughly the **last month**, status `New`, sorted by date. Widen the time window or change the status filter if the user asks for more history or already-actioned items.

### `listTopRecentSubscribedSignals` (cross-buyer)
Top recent signals across the buyers/bridges the user is **subscribed to** — the cross-account feed. Takes no buyer id. Use for "daily leads" / "what's new across my accounts."

### `getBuyerSummary` (hand-off)
When the user actually wants a synthesized narrative rather than a raw feed, use `buyer-summary` instead of (or after) listing signals.

## Workflow
1. **Decide scope.** A specific buyer is named → per-buyer. No single buyer / daily-triage phrasing → cross-buyer.
2. **Per-buyer:** ensure the buyer is identified (`buyer-identification`), then `listRecentBuyerSignals`. Lead with the freshest signals, each with its date. If the feed is thin or empty, say so and offer `buyer-summary` (synthesized) or `document-research` (underlying evidence) — do **not** silently fall back to the web.
3. **Cross-buyer:** `listTopRecentSubscribedSignals`, then group by recency / buyer / type and prioritize into a ranked list with a one-line "why it matters / suggested next action" per item.
4. **Drill into a signal.** Signals often reference an opportunity or document. When the user wants the detail behind one, hand off to `document-research` (`researchBuyerFiles` / `viewFileContents` / `getOpportunityLineItems`).

## Scope limits
- There are two supported scopes: a single buyer (`listRecentBuyerSignals`) and the user's subscribed feed (`listTopRecentSubscribedSignals`).
- "All signals across every bridge, including ones I don't follow" is **not** available. If asked, say so explicitly and offer the subscribed-feed scope — never return nothing and never imply you searched everything.

## Important
- Signals are dated evidence — cite the dates and don't extrapolate beyond what the feed says.
- Prefer the Starbridge feed over web research for recency questions; only consider the web after the feed is exhausted, and say what you found in the feed first.
- If the requested scope isn't supported, name the supported scope you used instead of degrading silently.
