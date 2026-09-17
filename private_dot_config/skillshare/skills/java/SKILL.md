---
name: Java / Maven Build SKILL
description: Things to do with java and maven
---

# Running Maven

Whenever running maven to build your changes, run with the profile "patch" enabled (use -Ppatch on the command line)
to automatically apply any ErrorProne based improvements.

# Apply OpenRewrite cleanups

After making any changes, and seeing that they build and run successfully,
process the changes with:

    mvn clean org.openrewrite.maven:rewrite-maven-plugin:runNoFork spotless:apply clean install

This will apply any recommended rewrites/optimizations from the OpenRewrite project.
