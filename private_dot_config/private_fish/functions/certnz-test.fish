function certnz-test --description "certnz-test <count> <description>"
  set count $argv[1]
  set desc $argv[2..-1]

  for i in (seq 1 $count)
    swaks --from gordon.king.qsr@smxemail.com --to test@certnztest.co.nz --server ausmta02:1025 --header-Subject "$i: $desc" -tls --body "$i: $desc"
  end
end
