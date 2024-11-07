function clang-code-format-modified-from-develop
  git diff-tree --no-commit-id --name-only -r (git merge-base origin/develop HEAD) HEAD | grep "\.java" | xargs clang-format -i -style=file
  fd -Ig "*.orig" -x rm "{}" ";"
end
