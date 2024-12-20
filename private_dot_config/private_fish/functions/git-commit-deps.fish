function git-commit-deps
    if test -f pom.deps
        if test -f release.properties
            echo "Found release.properties, aborting..."
        else
            mvn-resolve
            git clean -fd
            set VERSION (smx-build --show-short-version)
            echo "build(deps): Synced bill-of-materials" >COMMIT_MSG.txt
            echo "" >>COMMIT_MSG.txt
            grep resolved pom.deps >>COMMIT_MSG.txt
            mvn com.smxemail:rangeresolver-maven-plugin:lock-deps
            git commit -F COMMIT_MSG.txt (fd "pom.*") (fd "tile.xml")
            rm COMMIT_MSG.txt
        end
    else
        echo "Missing pom.deps file in working directory.."
    end
end
