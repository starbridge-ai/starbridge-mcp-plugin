#!/usr/bin/env bash
# PreToolUse gate for unlockBuyerContact.
# unlockBuyerContact spends credits, so we force an explicit user confirmation
# even under auto-approve / bypass permission modes. The hooks.json matcher
# already scopes this to that tool, so we unconditionally request "ask".
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"unlockBuyerContact spends credits to unlock this contact. Confirm the per-contact cost and remaining balance with the user before proceeding."}}
JSON
