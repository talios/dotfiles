function remux-status
  viddy "pueue status -g remux --json | jq -c '.tasks.[] | {id: .id, status: .status, file: .command | match(\".*--input \\\"(.*)\\\".*\") | .captures[0].string}'"
end
