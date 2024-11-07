function diff-smx3-changes
    cd /Users/amrk/IdeaProjects/securemx/smx3
    for dep in (smx-build -l | grep java | cut -d ' ' -f 3)
        git -C $dep difftool
    end
end
