dis=~/.cache/lingshin/fortune.txt

fortune -s | sed "s/\x1B\[[0-9;]*[mK]//g" >$dis
