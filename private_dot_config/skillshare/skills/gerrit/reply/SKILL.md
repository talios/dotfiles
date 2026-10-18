---
name: gerrit-reply
description: Post replies to Gerrit code review comments, or a review message, on a change over SSH. Use when the user asks to reply to, respond to, answer or mark "Done" on Gerrit review comments, or to post a message on a Gerrit change.
---

Posts a review to Gerrit (`gerrit.smxemail.com`) with the bundled script
(path relative to this skill's base directory), which pipes Gerrit's
`ReviewInput` JSON to `gerrit review --json` over SSH:

```bash
scripts/gerrit-reply.sh [--dry-run] [--no-open] <change>,<patchset> < review.json
```

## Before posting

Posting is visible to the whole team and emails the reviewers, so:

1. Find the comments with the `gerrit-comments` skill. Its output gives the
   change number, and the file, line and patch set of each comment.
2. Draft the replies and show them to the user. Only post once the user has
   approved the wording.
3. Run with `--dry-run` first to check the payload, then post for real.

## Payload

```json
{
  "message": "Addressed in patch set 11.",
  "comments": {
    "src/main/java/Foo.java": [
      { "line": 28, "message": "Done", "unresolved": false }
    ],
    "/COMMIT_MSG": [
      { "line": 1, "message": "Shortened the summary.", "unresolved": false }
    ]
  },
  "omit_duplicate_comments": true
}
```

- `comments` is keyed by file path relative to the repository root, exactly
  as `gerrit-comments` prints it (including `/COMMIT_MSG`).
- Post each reply to the **patch set the original comment is on**, at the
  same file and line, so it appears beside that comment. Comments for
  different patch sets need separate posts.
- Omit `line` for a file-level comment (shown as `:file` by `gerrit-comments`).
- `unresolved: false` for a "Done" style reply; `true` when it's a question
  back to the reviewer or the point is still open.
- `message` is the cover message; it can be omitted when there are only
  inline comments, and `comments` can be omitted for a message-only reply.
- Don't add `labels` (votes) unless the user asks for one.

## Limitations

- Gerrit's SSH interface doesn't expose comment IDs, so a reply can't set
  `in_reply_to`. It is posted as a new comment at the same location, not
  threaded under the original, and doesn't resolve the original's thread.
  To make up for this, after posting the script opens each commented file in
  the browser at its first commented line (or the change itself when there
  were no inline comments), so the developer can resolve the original
  threads by hand. Pass `--no-open` to skip it. Tell the user which threads
  still need resolving.
- If any path isn't a file in that patch set, or a line is out of range,
  Gerrit rejects the whole review and nothing is posted. Fix the payload and
  retry.

## Environment

- `GERRIT_HOST` / `GERRIT_PORT`: default `gerrit.smxemail.com` / `29418`.
