#!/bin/fish

if string match '*kitty' $TERM --quiet
    fd . ~/.config/lingshin/fastfetch-icons | shuf -n 1
else
    echo hello
end
