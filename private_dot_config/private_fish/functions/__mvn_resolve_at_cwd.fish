function __mvn_resolve_at_cwd --on-event cwd
    if test -f pom.deps
        mvn-resolve
    end
end
