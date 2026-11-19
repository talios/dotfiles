function ensure-develop-current --description "Sync develop and master (git) or fetch and check the develop base (jj)"
    if not test -d .jj
        echo ".jj does not exist - assuming git repository."
        if test "$(git branch --show-current)" != develop
            echo "You must be on the develop branch!" >&2
            return 1
        end
        echo "• Pulling latest develop..."
        git pull origin develop; or return
        echo "• Checking out master branch for updates..."
        git checkout master; or return
        git pull origin master
        git checkout develop
    else
        echo ".jj found - assuming jujutsu repository."
        echo "• Fetching latest develop..."
        jj git fetch; or return
        if not string match -q 'develop*' -- "$(jj baseb)"
            echo "Your working copy must be off the develop branch!" >&2
            return 1
        end
    end
end
