---
name: Jujutsu Usage
description: Tell claude how I work with jujutsu
---

For the most part, I use Jujutsu (JJ) as my version control tool of
choice, over plain git.

If the working directory contains a .jj directory, then assume the repository
being worked with is a Jujutsu repository, and the jj commands should always
be used over git commands.

Before doing any work, ask me if I want to start a fresh change (run `jj new develop`)
or additional work (run `jj new`).

## Commit Descriptions

- Summaries should be 50 characters, or as close to it as possible.
- Body text should be wrapped at 72 characters.
- When mentioning/references changes, inline the commit message, with a MarkDown style
  footnote.

  The footnote should mention both the jujutsu change-id *and* the short
  format of a git commit SHA using the format "change-id (sha: sha): commit summary"

  A Markdown footnote is identified by '[^1]' (an incrementing number start from 1) following the body text, and '[^1]: Footnote content.' at the end of the message.

  Further information about Markdown Footnotes can be found at https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#footnotes
- When repeating refernces to commits, just include the appropriate footnote reference, there's no need to repeat the commit message.

