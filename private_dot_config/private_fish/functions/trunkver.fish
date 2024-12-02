function trunkver
  set buildref $argv[1]
  if not test -n "$buildref"
    set buildref 0
  end

  docker run --rm ghcr.io/crftd-tech/trunkver:latest generate --build-ref "$buildref" --source-ref "g$(git rev-parse --short HEAD)"
end
