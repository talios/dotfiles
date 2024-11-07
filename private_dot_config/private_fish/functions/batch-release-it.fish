function batch-release-it
    for project in $argv
        release-it $project
    end
end
