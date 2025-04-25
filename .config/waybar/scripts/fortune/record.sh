src=~/Documents/MyDocs/fortune/current.txt
dis=~/Documents/MyDocs/fortune/interesting.txt

printf "\n----%s-----\n" "$(date)" >>$dis
cat $src >>$dis
