function dlt
  mkdir -p "/Users/amrk/Music/Tidal Staging/Album"
  for album in $argv
    tidal-dl -l $album
  end
end
