function drstats
    echo "" > /tmp/drstats.txt
    for host in $argv
        echo "DR Manager Stats for $host" >> /tmp/drstats.txt
        echo "" >> /tmp/drstats.txt
        curl -sn https://disaster-manager-app.$host.smxemail.com/reports/summary | \
            jq -r '. | to_entries | sort_by(.key)' | \
            jp -type bar -x ..key -y ..value -height 10 -width 80 >> /tmp/drstats.txt
        echo "" >> /tmp/drstats.txt
    end

    freeze --config user --output /tmp/drstats.png /tmp/drstats.txt
    
    # freeze \
    #     --margin 10 \
    #     --padding 5 \
    #     # --window \
    #     --theme "igor" \
    #     --language txt \
    #     --border.width 1 --border.color "#515151" --border.radius 8 \
    #     --shadow.blur 20 \
    #     --shadow.x 0 \
    #     --shadow.y 10 \
    #     # --font.family "PragmataPro Mono Liga" \
    #     --font.size 8 \
    #     # --font.ligatures \
    #     --output /tmp/drstats.png /tmp/drstats.txt    
    
    ~/Downloads/arm64/imgcopy /tmp/drstats.png
end
