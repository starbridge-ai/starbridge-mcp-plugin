#!/usr/bin/env bash
# PreToolUse gate for setBridgeRowStatus.
# setBridgeRowStatus mutates a Bridge row, so we force an explicit user
# confirmation even under auto-approve / bypass permission modes. The
# hooks.json matcher already scopes this to that tool, so we always "ask".
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"setBridgeRowStatus changes a Bridge row's status (a write to your Starbridge data). Confirm the exact row and target status with the user before proceeding."}}
JSON
