function check-dep-release
    set artifact $argv[1]

    for pom in (rg --type-add 'deps:*.deps' -t deps $artifact -l | rg -v materials | cut -d '/' -f 1 | sort | uniq)
        # git -C $pom status
        if git -C $pom diff-index --quiet HEAD --
            echo "$pom clean"
        else
            if test -d $pom/.jj
                echo "JJ is dirty, release $pom needed!"
            else
                echo "Git is dirty, release $pom needed!"
            end
        end
    end
end
