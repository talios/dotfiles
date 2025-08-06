function qsr-prod-test --description "qsr-prod-test <count> <description>"
  set count $argv[1]
  set desc $argv[2..-1]
  set PASSWORD (op --account HCGPZX5USVFSLJVQPCM6HLETMU item get "Calibre Gmail SMTP" --fields=password --reveal)

  for i in (seq 1 $count)
    swaks --from mark@talios.com \
        --to markd@o365filter.com \
        --server smtp.gmail.com:587 -a PLAIN --auth-user mark@talios.com \
        --auth-password $PASSWORD \
        --header-From "Mark <mark@talios.com>" \
        --header-Subject "$i: $desc" -tls --body "$i: $desc"
  end
end
