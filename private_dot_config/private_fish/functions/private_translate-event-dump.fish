# 980CF0DE-B0DB-46E9-A90A-0AB2748712CD

function translate-event-dump
    set file $argv[1]

    echo "Translating events in $file:"

    echo -ne '#               (0%)\r'
    sed -i '' -e 's/ALLOW_FROM_USER_POLICY/Whitelist/g' $file
    echo -ne '##             (10%)\r'
    sed -i '' -e 's/ALLOW_IP_ADDRESS_POLICY/Whitelist/g' $file
    echo -ne '###            (20%)\r'
    sed -i '' -e 's/UNKNOWN/Unknown/g' $file
    echo -ne '####           (30%)\r'
    sed -i '' -e 's/AAMTA_RECEIVED/Received/g' $file
    echo -ne '#####          (40%)\r'
    sed -i '' -e 's/AAMTA_REJECTED/Rejected/g' $file
    echo -ne '######         (50%)\r'
    sed -i '' -e 's/CLEAN/Clean/g' $file
    echo -ne '#######        (60%)\r'
    sed -i '' -e 's/DELIVERED/Delivered/g' $file
    echo -ne '########       (70%)\r'
    sed -i '' -e 's/MTA_EXPIRED_FROM_QUEUE/Expired From Queue/g' $file
    echo -ne '#########      (80%)\r'
    sed -i '' -e 's/MTA_QUEUED/Queued/g' $file
    echo -ne '##########     (90%)\r'
    sed -i '' -e 's/RECIPIENT_MTA_REJECTED/Rejected/g' $file
    echo     '###########   (100%)'
    echo "Done."

end

