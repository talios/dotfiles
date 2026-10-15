function check-dep-release
    set artifact $argv[1]

    for pom in (rg --type-add 'deps:*.deps' -t deps $artifact -l | rg -v materials | cut -d '/' -f 1 | sort | uniq)
        test -d $pom; or continue
        if test -d $pom/.jj
            # Non-empty changes on top of develop (or trunk() if there's no develop bookmark)
            set -l changes (jj -R $pom log --no-graph -T 'change_id.short() ++ "\n"' \
                -r '(coalesce(present(develop), trunk())..@) ~ empty()' 2>/dev/null)
            or begin
                echo "jj log failed in $pom"
                continue
            end
            if test (count $changes) -eq 0
                echo "$pom clean"
            else
                echo "JJ is dirty, release $pom needed!"
            end
        else
            git -C $pom update-index -q --refresh >/dev/null 2>&1
            if git -C $pom diff-index --quiet HEAD --
                echo "$pom clean"
            else
                echo "Git is dirty, release $pom needed!"
            end
        end
    end
end
