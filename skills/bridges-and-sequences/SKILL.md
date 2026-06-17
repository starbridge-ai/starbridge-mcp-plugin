---
name: bridges-and-sequences
user-invocable: false
description: "Navigate, read, and analyze the user's own Starbridge Bridges (saved tables of matches) and outreach Sequences — list them, inspect column definitions and rows, run analysis or visualization over the data, follow the bridge↔sequence merge-field link, and update a single row's status."
when_to_use: "Use when the request is about the user's OWN saved Bridges or Sequences rather than one external institution. Example triggers — 'list my bridges', 'what's in my <X> bridge', 'analyze / visualize this bridge', 'map competitor density across my bridge', 'what are the recurring themes in this bridge', 'plot buyers by <attribute>', 'show my sequences', 'what merge fields does this sequence use', 'which bridge columns feed this sequence', 'mark this row as <status>'. This is workspace data — for facts about a single institution use buyer-summary / document-research / buyer-attributes instead. Run buyer-identification only if the user pivots to a specific institution."
---

# Bridges and Sequences

Operates over the user's own Starbridge **Bridges** (saved tables of matches the platform produced) and outreach **Sequences**. Use it to list and inspect these workspace objects, pull and analyze their rows, follow the link between a sequence and its source bridge columns, and update a single bridge row's status.

This is the user's workspace, not external buyer data. For questions about a specific institution (priorities, documents, contacts, scores) use `buyer-summary`, `document-research`, `contact-search`, or `buyer-attributes`.

## When to Use
- Listing, opening, or explaining the user's bridges or sequences
- Analysis or visualization over a bridge's rows (competitor density, theme analysis, plotting by an attribute)
- Understanding which bridge columns feed a sequence and which merge fields a sequence exposes
- Changing a single bridge row's status

## Tools

### `listBridges`
Finds the user's bridges; filter by query or type. If several match the request, confirm which one before drilling in.

### `getBridge`
Returns one bridge's metadata by id. Note: per-column configuration is **not** included here — use `getBridgeColumnMetadata` for that.

### `getBridgeColumnMetadata`
Lists the bridge's columns with their per-type settings (link, web-agent, vendor-presence, email-generation, webhook) and `additionalFields` synthetic references. **Call this before building any column-targeted filter or interpreting a column** — column meaning is not discoverable from `getBridge` or from row values alone. Never guess what a column means.

### `listBridgeRows`
The data-bearing call. Each row carries a processing status (`NotProcessed`, `Queued`, `Processing`, `Processed`, `Failed`, `Skipped`), an optional buyer/organizer association, an `updatedAt` timestamp, and a `columns` map **keyed by the human-readable column name** (not columnId), with values polymorphic per the column's `fieldFormat`.
- Pagination: `pageNumber` is 1-based; `pageSize` has a **maximum of 100** (default 10). Start at `pageNumber=1` and increment until `pageNumber == totalPages`. Do not assume a smaller cap and refuse a large pull.
- Prefer narrowing server-side with `filters`, `sorts`, and `query` (in the request body) over scanning every page.
- Eventual consistency: a just-changed row may not appear in listing/sort/filter immediately — if it's missing where you expect it, retry shortly.

### `setBridgeRowStatus` (write — confirm first)
The only mutating tool here. Sets one row's user-facing status (`newStatus`, a fixed enum: `New`, `Actioned`, `Saved`, `Attending`, `Sponsoring`, `Not Interested`). The `rowId` must belong to the given `bridgeId`. **Confirm the exact row and target status with the user before calling**, and read the tool's input schema for the current valid status values rather than hardcoding them.

### Sequences: `listSequences` → `getSequence` → `getSequenceDataAttributes` → `listSourceBridgeColumnsForSequence`
- `getSequenceDataAttributes` returns the sequence's data attributes / merge fields available for personalization.
- `listSourceBridgeColumnsForSequence` maps those merge fields back to the source bridge's columns — this is the bridge↔sequence join. Use it when the user asks which bridge data feeds a sequence or which merge fields are available.

## Workflow

**Inspecting a bridge**
1. `listBridges` to find the target; if multiple match, confirm with the user.
2. `getBridge` for metadata, then `getBridgeColumnMetadata` to learn what each column means **before** filtering.
3. `listBridgeRows` with `filters` / `sorts` / `query` to fetch the rows you need; paginate `pageNumber` 1..`totalPages` with `pageSize` ≤ 100.

**Analyzing or visualizing a bridge**
1. Identify the columns via `getBridgeColumnMetadata`.
2. Pull the relevant rows with `listBridgeRows` (narrow with filters; paginate ≤ 100/page).
3. For more than ~a page of rows, write the rows to a file and aggregate / plot with a script — don't try to reason over hundreds of rows inline. This is where the MCP shines (e.g. competitor-density maps, theme rollups).

**Inspecting a sequence**
1. `listSequences` → `getSequence` for the target.
2. `getSequenceDataAttributes` for available merge fields.
3. `listSourceBridgeColumnsForSequence` to see which source bridge columns supply them.

**Updating a row**
1. Confirm the exact row and the intended status with the user.
2. Call `setBridgeRowStatus`.

## Important
- Bridges and sequences are the user's own workspace objects — don't conflate them with external buyer research (`buyer-summary`, `document-research`).
- Always read `getBridgeColumnMetadata` before interpreting or filtering on a column; never invent a column's meaning.
- `pageSize` max is 100. For large data, paginate or narrow with `filters`/`sorts`/`query` — never refuse a pull by assuming a lower limit.
- `setBridgeRowStatus` mutates data: confirm first, and surface the valid status set from the tool schema.
- Report only the scope `listBridges` actually returns; do not assert a broader access scope (e.g. "all bridges in the org") that you haven't verified.
