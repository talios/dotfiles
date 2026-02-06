function smx3-log-query --description "smx3-log-query <env> <file> <patterns>"
  set env "$argv[1]log01"
  set mapper $argv[2]
  set patterns $argv[3..-1]

  set greps ""
  for pattern in $patterns
    set greps $greps "| grep '$pattern' "
  end

  echo "Grepping " $greps

  # ssh markd@$env -C "zcat /var/smx/logs/smx3/portal/request.log-20231* | grep '| response' $greps" | cut -d '|' -f 6 | jq -c -f $mapper
  ssh markd@$env -C "zcat /var/smx/logs/smx3/portal/request.log-20240* | grep '| response' $greps" | cut -d '|' -f 6 | jq -c -f $mapper
  ssh markd@$env -C "cat /var/smx/logs/smx3/portal/request.log         | grep '| response' $greps" | cut -d '|' -f 6 | jq -c -f $mapper
end
