function silicon-it
  set format $argv[1]
  set filename $argv[2]
  silicon --shadow-blur-radius 5 --shadow-offset-x 5 --shadow-offset-y 5  --background "#eeeeee" --font "Berkeley Mono" -l $format --output $filename.png  < $filename
end
