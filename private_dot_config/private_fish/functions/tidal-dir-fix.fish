
function tidal-dir-fix
  cd "/Volumes/Media Content-1/Plex Content/Music/Tidal Rips/Album"
  for prefix in $argv
    echo "• Fixing tidal album directory names for $prefix*"
    set artists (command ls $prefix*)
    for i in "$artists*"
      echo "• Fixing tidal album directory names for artist $i*"
      # cd "$i"
      # rename-tidal-dir -s . --dry-run
      # cd ..
    end
  end
end
