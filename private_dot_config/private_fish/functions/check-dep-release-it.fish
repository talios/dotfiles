function check-dep-release-it --argument-names artifact filterarg
    cd /Users/amrk/IdeaProjects/securemx/smx3
    if test -n "$filterarg"
        set filter $filterarg
    else
        set filter "."
    end

    echo -n "batch-release-it "
    for pom in (rg --type-add 'deps:*.deps' -t deps $artifact -l | rg -v materials | cut -d '/' -f 1 | sort | uniq | rg $filter | rg -v pom.xml | rg -v '(selfrelease|smx3-integration|smx3.documentation)')
        if test -d $pom
            if git -C $pom diff-index --quiet HEAD --
                # ignore
            else
                echo -n "$pom "
            end
        end
    end
end
