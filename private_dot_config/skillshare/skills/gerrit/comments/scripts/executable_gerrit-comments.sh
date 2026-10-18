#!/usr/bin/env bash
# Dump Gerrit review comments for a change in an LLM-friendly format.
# Usage: gerrit-comments <query>   e.g. gerrit-comments MANAGE-135
# Comments by users in GERRIT_IGNORE_USERS (comma-separated usernames or
# names, default "markd") are skipped; set it to "" to show everyone.
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: $(basename "$0") <gerrit query>" >&2
  exit 1
fi

GERRIT_HOST="${GERRIT_HOST:-gerrit.smxemail.com}"
GERRIT_PORT="${GERRIT_PORT:-29418}"
GERRIT_IGNORE_USERS="${GERRIT_IGNORE_USERS-markd}"

ssh -p "$GERRIT_PORT" "$GERRIT_HOST" gerrit query --format json --comments --patch-sets "$@" |
  jq -r --arg ignore "$GERRIT_IGNORE_USERS" '
    ($ignore | split(",") | map(select(. != ""))) as $ignored |
    select(.type != "stats") |
    "# Change \(.number): \(.subject)\n\(.url)\n",
    "## Inline comments\n",
    (.patchSets // []
      | sort_by(.number)
      | .[]
      | .number as $ps
      | (.comments // [])[]
      | select([.reviewer.username, .reviewer.name] | any(. as $u | $ignored | index($u)) | not)
      | "### \(.file):\(.line // "file") (patch set \($ps))\n**\(.reviewer.username // .reviewer.name)**: \(.message)\n")
  '
