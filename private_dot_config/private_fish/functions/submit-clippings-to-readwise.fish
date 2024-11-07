function submit-clippings-to-readwise
  set PASSWORD (op item get "Calibre Gmail SMTP" --fields=password)
  swaks --from mark@talios.com --to add@readwise.io --server smtp.gmail.com --auth-user mark@talios.com --auth-password $PASSWORD --header-Subject "Kindle Clippings" -tls --attach @"/Volumes/Kindle/documents/My Clippings.txt"
end
