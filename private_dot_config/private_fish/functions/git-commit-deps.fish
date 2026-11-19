function git-commit-deps
    if test -f pom.deps
        if test -f release.properties
            echo "Found release.properties, aborting..."
        else
            if not ensure-develop-current
                echo "ensure-develop-current failed, aborting..." >&2
                return 1
            end
            mvn-resolve-locked
            git clean -fd
            if test -d .jj
                jj commit -m "build(deps): Synced bill-of-materials" (fd "pom.*") (fd "tile.xml") (fd "Dockerfile")
            else
                git commit -m "build(deps): Synced bill-of-materials" (fd "pom.*") (fd "tile.xml") (fd "Dockerfile")
            end
            # rm /tmp/COMMIT_MSG.txt
        end
    else
        echo "Missing pom.deps file in working directory.."
    end
end
