function drstats
    echo "" > /tmp/drstats.txt
    for host in $argv
        echo "DR Manager Stats for $host" >> /tmp/drstats.txt
        echo "" >> /tmp/drstats.txt
        curl -sn https://disaster-manager-app.$host.smxemail.com/reports/summary | \
            jq -r '. | to_entries | sort_by(.key)' | \
            jp -type bar -x ..key -y ..value -height 10 >> /tmp/drstats.txt
        echo "" >> /tmp/drstats.txt
    end

    set timestamp (date +"%s")
    set drstatsfile ~/temp/drstats-$timestamp

    freeze --config user --output $drstatsfile.png /tmp/drstats.txt
    cat /tmp/drstats.txt

    ~/Downloads/arm64/imgcopy $drstatsfile.png

    # ffmpeg -framerate 1 -pattern_type glob -i "/temp/drstats-*.jpg" -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p /temp/drstats.mp4
end
