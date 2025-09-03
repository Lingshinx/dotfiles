dis=~/.cache/lingshin/fortune.txt

content=$(tr "\n" "\r" <"$dis" | sed 's/\r$//;s/"/\\"/g')

printf '{"tooltip": "%s"}' "$content"
