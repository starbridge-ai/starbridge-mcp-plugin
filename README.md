# Starbridge MCP plugin for Claude Code

A [Claude Code plugin](https://code.claude.com/docs/en/plugins) that connects Claude Code to the
**Starbridge dashboard** through its OAuth-protected MCP server, and bundles the Starbridge GTM
skills so Claude knows how to drive the tools for buyer research and outbound.

- **MCP server:** `https://dashboard.starbridge.ai/mcp/oauth` (HTTP transport, OAuth 2.0)
- **Skills:** buyer identification, buyer attributes, buyer summary, contact search, document
  research, outbound email, bridges & sequences, buyer signals, bulk-request scoping

## Install

This repository is both a Claude Code **plugin** and a single-plugin **marketplace**, so you can
install it directly from GitHub:

```text
/plugin marketplace add starbridge-ai/starbridge-mcp-plugin
/plugin install starbridge-mcp@starbridge
```

Then authenticate the MCP server (opens a browser for the Starbridge OAuth flow):

```text
/mcp
```

Pick **starbridge** and follow the login prompt. Claude Code performs OAuth 2.0 dynamic client
registration + PKCE automatically against `https://auth.starbridge.ai`; you only need to approve in
the browser. When a session expires, run `/mcp` again and reconnect to re-authorize.

### Try it locally first

To test without installing from the marketplace, point Claude Code at the checked-out directory:

```bash
claude --plugin-dir /path/to/starbridge-mcp-plugin
```

Run `/reload-plugins` after editing any plugin file.

## What you get

### MCP server

Tools are exposed under the `starbridge` namespace (e.g. `mcp__starbridge__searchBuyers`):

| Tool | Purpose |
| --- | --- |
| `searchBuyers` | Find a buyer (institution) by name |
| `getBuyerAttribute` | Pre-computed scores/metrics for a buyer |
| `getBuyerSummary` | Synthesized buyer activity, priorities, and outreach context |
| `searchBuyerContacts` | Verified contacts at a buyer |
| `researchBuyerFiles` / `viewFileContents` | Internal documents (RFPs, board meetings, procurement) |
| `getOpportunityLineItems` | Line items from contracts / purchase orders |
| `runBuyerWebResearch` | Buyer-scoped public web research |
| `listBridges` / `getBridge` / `getBridgeColumnMetadata` / `listBridgeRows` | Read the user's saved Bridges, their column definitions, and rows |
| `setBridgeRowStatus` | Update a single Bridge row's status (the one write tool) |
| `listSequences` / `getSequence` / `getSequenceDataAttributes` / `listSourceBridgeColumnsForSequence` | Inspect outreach Sequences and the bridge↔sequence merge-field link |
| `listRecentBuyerSignals` / `listTopRecentSubscribedSignals` | Recent signals for one buyer, or across followed buyers |

The live server may expose additional tools; run `/mcp` to see the full list once connected.

### Skills

Bundled from
[`service.fastmcp`](https://github.com/starbridge-ai/service.fastmcp/tree/main/src/service_fastmcp/resources/skills).
These are **auto-invoked only**: Claude activates them on its own based on the request. They are
intentionally hidden from the `/` menu (`user-invocable: false` in each `SKILL.md`), so there are no
`/starbridge-mcp:*` slash commands to remember — just ask naturally.

| Skill | When Claude activates it |
| --- | --- |
| `buyer-identification` | First step — resolve which buyer the question is about |
| `buyer-attributes` | Pre-computed scores, budget, enrollment, SIS/LMS |
| `buyer-summary` | Strategy, priorities, call prep, "what do we know" |
| `contact-search` | Find contacts; prerequisite for outbound email |
| `document-research` | RFPs, board minutes, procurement, contracts, web research |
| `general-outbound-email` | Draft a personalized B2B outbound email |
| `bridges-and-sequences` | Navigate/analyze the user's own Bridges & Sequences (workspace data, not a buyer) |
| `buyer-signals` | "What's new about X" (per-buyer) and "daily leads" (cross-buyer) from the signal feed |
| `bulk-request-scoping` | Steer Clay-style bulk-enrichment asks — narrow, sample, or hand off before grinding |

## Layout

```text
starbridge-mcp-plugin/
├── .claude-plugin/
│   ├── plugin.json        # plugin manifest
│   └── marketplace.json   # makes this repo installable as a marketplace
├── .mcp.json              # Starbridge OAuth MCP server (HTTP transport)
├── skills/                # bundled GTM skills (one SKILL.md per directory)
└── README.md
```

## Maintaining the skills

The skills are mirrored from `service.fastmcp`. To refresh them after upstream changes, re-copy the
contents of `src/service_fastmcp/resources/skills/*/SKILL.md` into `skills/`, bump the `version` in
`.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`, and run `claude plugin validate .`.

> **Note:** `bridges-and-sequences`, `buyer-signals`, and `bulk-request-scoping` were authored in the
> plugin first. They should be upstreamed into `service.fastmcp/src/service_fastmcp/resources/skills/`
> so the dashboard MCP (web / Cowork) serves them too — until then they only ship to Claude Code.
