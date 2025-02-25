function __mvn_resolve_at_cwd --on-variable PWD
    if test -f pom.deps
        mvn-resolve
    end
end
