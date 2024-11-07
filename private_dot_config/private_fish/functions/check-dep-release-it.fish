function check-dep-release-it --argument-names 'artifact' 'filterarg'

  if test -n "$filterarg"
    set filter $filterarg
  else
    set filter "."
  end

  echo -n "batch-release-it "
  for pom in (rg --type-add 'deps:*.deps' -t deps $artifact -l | rg -v materials | cut -d '/' -f 1 | sort | uniq | grep $filter)
      # git -C $pom status
      if git -C $pom diff-index --quiet HEAD --
        # ignore
      else
          echo -n "$pom "
      end
  end
end
