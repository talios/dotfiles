function qsr-prod-test --description "qsr-prod-test <count> <description>"
  set count $argv[1]
  set desc $argv[2..-1]
  set PASSWORD (op item get "Calibre Gmail SMTP" --fields=password)

  for i in (seq 1 $count)
    swaks --from mark@talios.com --to mark.derricutt@o365filter.com --server smtp.gmail.com --auth-user mark@talios.com --auth-password $PASSWORD --header-Subject "$i: $desc" -tls --body "$i: $desc"
  end
end
