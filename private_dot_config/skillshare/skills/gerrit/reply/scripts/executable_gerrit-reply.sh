#!/usr/bin/env bash
# Post a Gerrit review (cover message and/or inline comments) over SSH.
# Usage: gerrit-reply [--dry-run] [--no-open] <change>,<patchset> < review.json
# The JSON on stdin is Gerrit's ReviewInput, as read by `gerrit review --json`.
# --dry-run validates and prints the payload without posting it.
# After posting, each commented file is opened in the browser at its first
# commented line, since replies can't resolve the original threads over SSH;
# --no-open skips that.
set -euo pipefail

dry_run=false
open_files=true
while [[ "${1-}" == --* ]]; do
  case "$1" in
    --dry-run) dry_run=true ;;
    --no-open) open_files=false ;;
    *) echo "unknown option: $1" >&2; exit 1 ;;
  esac
  shift
done

if [[ $# -ne 1 || ! "$1" =~ ^[0-9]+,[0-9]+$ ]]; then
  echo "usage: $(basename "$0") [--dry-run] [--no-open] <change>,<patchset> < review.json" >&2
  exit 1
fi

GERRIT_HOST="${GERRIT_HOST:-gerrit.smxemail.com}"
GERRIT_PORT="${GERRIT_PORT:-29418}"

# Validate and compact the payload; jq fails on malformed JSON.
payload="$(jq -c 'if type != "object" then error("review input must be a JSON object") else . end')"

if $dry_run; then
  jq . <<<"$payload"
  exit 0
fi

ssh -p "$GERRIT_PORT" "$GERRIT_HOST" gerrit review --json "$1" <<<"$payload"

# The review has posted; everything below is best-effort so a failure here
# can't look like a failed post and prompt a duplicate retry.
if $open_files && command -v open >/dev/null; then
  change="${1%,*}"
  patchset="${1#*,}"
  change_url="$(ssh -p "$GERRIT_PORT" "$GERRIT_HOST" gerrit query --format json "change:$change" |
    jq -r 'select(.type != "stats") | .url // empty')" || true
  if [[ -z "$change_url" ]]; then
    echo "posted; couldn't look up the change URL to open it" >&2
    exit 0
  fi
  # Gerrit's file URLs are <change url>/<patchset>/<path>#<line>; /COMMIT_MSG
  # keeps its leading slash, giving <patchset>//COMMIT_MSG.
  urls="$(jq -r --arg base "$change_url/$patchset/" '
    (.comments // {}) | to_entries[]
    | $base + .key + ([.value[].line | numbers] | if length > 0 then "#\(min)" else "" end)
  ' <<<"$payload")"
  for url in ${urls:-$change_url}; do
    open "$url" || echo "posted; couldn't open $url" >&2
  done
fi
