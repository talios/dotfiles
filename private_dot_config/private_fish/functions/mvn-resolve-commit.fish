function mvn-resolve-commit
  if test -f pom.deps
      if test -f release.properties
          echo "Found release.properties, aborting..."
      else
        set artifact $argv[1]
        git diff -U0 | grepdiff -E '$artifact' --output-matching=hunk
        echo
        echo "Enter version: "
        read version
        git diff -U0 | grepdiff -E '$artifact' --output-matching=hunk | git apply --cached --unidiff-zero
        git commit -m "build(deps): Updated $artifact to $version"
      end
  else
      echo "Missing pom.deps file in working directory.."
  end
end
