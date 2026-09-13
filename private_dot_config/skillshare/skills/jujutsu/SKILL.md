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
