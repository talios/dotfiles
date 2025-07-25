function release-it
    set project $argv[1]
    cd /Users/amrk/IdeaProjects/securemx/smx3/$project
    if test -d .jj
        set base (string split " " (command jj baseb))
        if not string match -r develop $base
            echo "• Repository is managed by Jujutsu, and working copy is not develop, please release $project manually"
            return
        end
    end
    # if not test (git diff-index --quiet HEAD -- ; and echo "yes")
    #     echo "• Repository dirty, please resolve before releasing $project"
    #     return
    # end
    # git checkout develop
    echo "• Resolving dependencies for $project"
    mvn-resolve >~/Desktop/release-it.log
    if not test (git diff-index --quiet HEAD -- ; and echo "yes")
        echo "• Repository dirty after resolving dependencies - releasing $project"
        git-commit-deps
        git clean -fdx
        git mvnrelease && echo "• Released $project" && cd /Users/amrk/IdeaProjects/securemx/smx3/
    end
end
