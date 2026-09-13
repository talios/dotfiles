function jj-feature
    set feat $argv[1]
    set repo $argv[2]

    cd ~/IdeaProjects/securemx/smx3
    cd $repo
    mkdir -p ../../features/$feat
    jj workspace add ../../features/$feat/$repo --name $feat -r @
    jj new develop
    cd ../../features/$feat/$repo
end
