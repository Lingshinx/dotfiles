src=~/.cache/lingshin/fortune.txt
dis=~/.local/share/lingshin/fortune.txt

printf "\n----%s-----\n" "$(date)" >>$dis
cat $src >>$dis
