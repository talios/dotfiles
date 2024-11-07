function migrate-to-zimbra
  set mailbox $argv[1]
  curl -X POST -u mark.derricutt@smxemail.com:m68pD3JJ https://portal.hu1.smxemail.com/api/sp/mailbox/$mailbox/migration-in-progress
  curl -u mark.derricutt@smxemail.com:m68pD3JJ https://portal.hu1.smxemail.com/api/sp/mailbox/$mailbox/migrated  -H "Content-Type: application/json" -X POST --data-binary "{\"hosting-platform\": \"#zimbra\"}"
  echo "• Migrated $mailbox to #zimbra"
end

function hughes-mailbox-status
  set mailbox $argv[1]
  curl -u mark.derricutt@smxemail.com:m68pD3JJ https://portal.hu1.smxemail.com/api/sp/mailbox/$mailbox/migration-settings | jq --raw-output '"• $mailbox is \(.migration-status) on \(.hosting-platform)"'
end
