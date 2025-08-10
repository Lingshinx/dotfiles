dis=~/Documents/MyDocs/fortune/current.txt

content=$(tr "\n" "\r" <"$dis" | sed 's/\r$//;s/"/\\"/g')

printf '{"tooltip": "%s"}' "$content"
