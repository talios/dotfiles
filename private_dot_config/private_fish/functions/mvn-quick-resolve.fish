
function mvn-quick-resolve
    if test -f pom.deps
        if test -f release.properties
            echo "Found release.properties, aborting..."
        else
            mvn -q com.smxemail:rangeresolver-maven-plugin:1.2.14:resolve-deps $argv[1]..
        end
    else
        echo "Missing pom.deps file in working directory.."
    end
end
