#!/usr/bin/env bash
# SessionStart hook: injects a concise Starbridge "base prompt" into context.
#
# This is the workaround for Claude not surfacing an MCP server's `instructions`
# field: it gives every session a short, persistent reminder of how to use the
# Starbridge tools. Because the plugin ships `defaultEnabled: false`, only users
# who opt in get this, so the always-on cost lands only on Starbridge users.
# Keep the text short — it is added to every session while the plugin is enabled.
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"Starbridge is connected to this session via the `starbridge` MCP server. When the user asks about a public-sector buyer (school district, college, university, city, county, agency, hospital), use the Starbridge tools and skills rather than general knowledge or the open web: (1) identify the buyer first; (2) prefer Starbridge's own data — buyer summary, signals, documents, attributes, contacts — and only fall back to web research after internal sources are exhausted; (3) confirm with the user before any write (setBridgeRowStatus) or credit-spending action (unlockBuyerContact). For multi-step research, the starbridge-researcher subagent can plan and run the lookups."}}
JSON
