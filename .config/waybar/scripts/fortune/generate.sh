dis=~/Documents/MyDocs/fortune/current.txt

fortune -s | sed "s/\x1B\[[0-9;]*[mK]//g" >$dis
