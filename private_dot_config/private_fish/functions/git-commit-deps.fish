function git-commit-deps
    if test -f pom.deps
        if test -f release.properties
            echo "Found release.properties, aborting..."
        else
            mvn-resolve
            git clean -fd
            echo "build(deps): Synced bill-of-materials" >/tmp/COMMIT_MSG.txt
            echo "" >>/tmp/COMMIT_MSG.txt
            grep resolved pom.deps >>/tmp/COMMIT_MSG.txt
            mvn com.smxemail:rangeresolver-maven-plugin:lock-deps
            if test -d .jj
                jj desc --stdin < /tmp/COMMIT_MSG.txt
                # jj split (fd "pom.*") (fd "tile.xml") (fd "Dockerfile")
                jj commit (fd "pom.*") (fd "tile.xml") (fd "Dockerfile")
                jj desc -m ""
            else
                git commit -F /tmp/COMMIT_MSG.txt (fd "pom.*") (fd "tile.xml") (fd "Dockerfile")
            end
            rm /tmp/COMMIT_MSG.txt
        end
    else
        echo "Missing pom.deps file in working directory.."
    end
end
