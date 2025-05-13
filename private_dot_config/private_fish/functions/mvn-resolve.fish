function mvn-resolve
    set RANGERESOLVER 1.2.22
    if test -f pom.deps
        if test -f release.properties
            echo "Found release.properties, aborting..."
        else
            mvn -q clean com.smxemail:rangeresolver-maven-plugin:$RANGERESOLVER:resolve-deps \
                com.smxemail:rangeresolver-maven-plugin:$RANGERESOLVER:update-lower-bounds
            mvn -q com.github.ekryd.sortpom:sortpom-maven-plugin:4.0.0:sort org.codehaus.mojo:tidy-maven-plugin:1.3.0:pom
        end
    else
        echo "Missing pom.deps file in working directory.."
    end
end
