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
- Body text should be wrapped at 70 characters.
- Don't directly reference method or class names, and keep the message to a description of changes to behaviour and any issues found.

## On Rebase

After rebasing changes, check the rebased commit descriptions for outdated git sha's and update them appropriately.

The descriptions should also be reevaluated based on the current changes in the commit, as rebasing may have moved changed to earlier commits etc.

## Post Commit

- Never leave the repository sitting directly on the commit, ALWAYS leave it on an empty working copy (run `jj new`)
