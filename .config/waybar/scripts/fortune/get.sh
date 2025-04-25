dis=~/Documents/MyDocs/fortune/current.txt

content=$(tr "\n" "\r" <"$dis" | sed 's/\r$//')

printf '{"tooltip": "%s"}' "$content"
