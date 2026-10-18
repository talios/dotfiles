---
name: gerrit-comments
description: Fetch Gerrit code review comments for a change as Markdown. Use when the user asks to read, address, fix or respond to review comments/feedback on a Gerrit change, or mentions Gerrit reviews for a ticket (e.g. "address the review comments on MANAGE-135").
---

Reviews for this work happen on Gerrit (`gerrit.smxemail.com`), accessed over
SSH. To pull the inline review comments for a change, run the bundled script (path relative to this skill's base directory):

```bash
scripts/gerrit-comments.sh <gerrit query>
```

The argument is any Gerrit query. Common forms:

- A ticket ID, matched against the commit message: `MANAGE-135`
- A change number: `change:12345`
- Open changes only: `MANAGE-135 status:open`

Output is Markdown, one block per change matched:

```
# Change <number>: <subject>
<url>

## Inline comments

### <file>:<line> (patch set <n>)
**<reviewer>**: <message>
```

`line` is `file` for file-level comments. Comments are ordered by patch set,
so later patch sets come last; comments on old patch sets may already be
resolved, so check the current code before acting on them.

## Environment

- `GERRIT_IGNORE_USERS`: comma-separated usernames or names whose comments
  are skipped. Defaults to `markd` (the user's own replies). Set to `""` to
  include everyone, e.g. when the user wants to see their own replies too.
- `GERRIT_HOST` / `GERRIT_PORT`: default `gerrit.smxemail.com` / `29418`.

## Addressing comments

When asked to address the comments, work through them one at a time against
the current code, and summarise at the end which ones were fixed, which were
already resolved, and which need the user's judgement.

To post replies back to Gerrit, use the `gerrit-reply` skill.
