# Contributing

Notes for developers working on the Starbridge Claude Code plugin. End-user docs live in
[`README.md`](./README.md).

## Test locally

Point Claude Code at the checked-out directory instead of installing from the marketplace:

```bash
claude --plugin-dir /path/to/starbridge-mcp-plugin
```

Run `/reload-plugins` after editing any plugin file.

## Layout

```text
starbridge-mcp-plugin/
├── .claude-plugin/
│   ├── plugin.json        # plugin manifest
│   └── marketplace.json   # makes this repo installable as a marketplace
├── .mcp.json              # Starbridge OAuth MCP server (HTTP transport)
├── skills/                # bundled GTM skills (one SKILL.md per directory)
├── README.md              # end-user docs
└── CONTRIBUTING.md        # this file
```

## MCP server

The plugin points at `https://dashboard.starbridge.ai/mcp/oauth` (HTTP transport, OAuth 2.0). Claude
Code handles dynamic client registration + PKCE automatically. Run `/mcp` after connecting to see
the live tool list.

## Skills

Skills are auto-invoked only (`user-invocable: false` in each `SKILL.md`), so they don't appear in
the `/` menu — Claude activates them based on the request. Each skill's `description` and
`when_to_use` frontmatter drive that auto-invocation, so keep them sharp and non-overlapping.

When adding or changing a skill:

1. Edit the relevant `skills/<name>/SKILL.md` (one directory per skill).
2. Bump the `version` in both `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`
   (minor bump for new skills or features, patch for fixes).
3. Run `claude plugin validate .`.
