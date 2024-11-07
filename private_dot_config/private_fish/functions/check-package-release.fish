function check-package-release
  set package $argv[1]

  for gitdir in (rg -t java $package -l | cut -d '/' -f 1 | sort | uniq)
      # git -C $pom status
      if git -C $gitdir diff-index --quiet HEAD --
          echo "$gitdir clean"
      else
          echo "Git is dirty, release $gitdir needed!"
      end
  end
end
