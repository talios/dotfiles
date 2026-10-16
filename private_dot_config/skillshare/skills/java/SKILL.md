---
name: Java / Maven Build SKILL
description: Things to do with java and maven
---

# Running Maven

Whenever running maven to build inflight changes, run with the profile "patch" enabled (use -Ppatch on the command line)
to automatically apply any ErrorProne based improvements.

If building just to verify changes work, do NOT use -Ppatch

# Apply OpenRewrite cleanups

After making any changes, and seeing that they build and run successfully,
process the changes with:

    mvn clean org.openrewrite.maven:rewrite-maven-plugin:runNoFork spotless:apply clean install

This will apply any recommended rewrites/optimizations from the OpenRewrite project.

# Manual Formatting Preferences

- Always include a blank line before a `return`, 'if', 'try', or 'throw' statement, unless that statement is the first line of the method.
- Always include a blank line between variable assignments and actual code.
 
