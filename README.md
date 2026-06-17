# Starbridge for Claude Code

Connect Claude Code to your Starbridge account and work with your buyer data by asking in plain
language — research institutions, find contacts, draft outreach, and dig into your own bridges,
sequences, and signals. No commands to memorize: just ask, and Claude picks the right Starbridge
tools for you.

## Get started

**1. Install** (run these in Claude Code):

```text
/plugin marketplace add starbridge-ai/starbridge-mcp-plugin
/plugin install starbridge-mcp@starbridge
```

**2. Connect your account:**

```text
/mcp
```

Pick **starbridge** and log in when the browser opens. That's it — you're connected. If your session
ever expires, run `/mcp` again and reconnect.

## What you can ask

Talk to it the way you'd brief a teammate. A few examples by what you're trying to do:

**Get up to speed on a buyer**
- "What are the top priorities for Lincoln Public Schools?"
- "What's their AI-adoption score, budget, and enrollment?"
- "What SIS does this district use?"
- "Help me prep for a call with Mesa County."

**Dig into documents, history, and spend**
- "What has the City of Austin purchased recently, and from whom?"
- "Find their open RFPs."
- "Does this district have a contract with <vendor>? When does it expire?"
- "What did the board discuss about <topic>?"

**Find the right people**
- "Who is the CIO at UCLA?"
- "Find procurement and IT contacts at this district."

**Draft outreach**
- "Draft a cold email to the superintendent about <your offering>."

**Stay on top of what's changing**
- "What's new about Washoe County School District?"
- "Give me my daily leads — what's new across the buyers I follow?"

**Work with your own bridges & sequences**
- "List my bridges."
- "Analyze my competitor-presence bridge and show me where they're winning."
- "What merge fields does this sequence use, and which bridge columns feed it?"

Asking for a huge bulk job (e.g. "enrich every row in this list")? Claude will help you scope it
down — narrow to a subset, run a sample first, or point you to the right tool — rather than grinding
through hundreds of slow calls.

## Notes

- **Read-focused.** This is built for research and enrichment. Creating and editing bridges still
  happens in the Starbridge app.
- **You stay in control.** Claude asks before each Starbridge action unless you've set it to
  auto-approve.

---

Working on the plugin itself? See [CONTRIBUTING.md](./CONTRIBUTING.md).
