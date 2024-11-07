function mvn-quick-deploy
    set artifact_version $argv[1]
    set artifact $argv[2]
    if not set -q argv[3]
        set prefix ""
    else
        set prefix "$argv[3]/"
    end

    if test -f {$prefix}{$artifact}.jar
        echo "Found jar file, deploying..."
        mvn deploy:deploy-file -DgroupId=com.openexchange -DartifactId={$artifact} -Dversion={$artifact_version} -DgeneratePom=true -Dpackaging=jar -DrepositoryId=smx-releases -Durl=https://nexus.az1.smxk8s.net/repository/maven-third-party -Dfile={$prefix}{$artifact}.jar
    else
        echo "Missing $prefix$artifact.jar file in working directory.."
    end
end
