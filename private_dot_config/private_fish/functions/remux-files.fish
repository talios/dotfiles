function remux-files
  for show in $argv
    for i in *$show*264*
      pueue add -g remux ~/go/bin/go265 --tmp /Volumes/crux/x265/ --path ./ --input \"$i\"
    end
  end
end
