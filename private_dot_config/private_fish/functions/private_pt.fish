function pt
  mkdir -p "/Users/amrk/Music/Tidal Staging/Album"
  for album in $argv
    echo "• Scheulding tidal download of $album"
    pueue add "tidal-dl -l $album && osascript -e 'display notification \"Download complete.!\" with title \"Background Tidal Download\"'"
  end
#  pueue status
end
