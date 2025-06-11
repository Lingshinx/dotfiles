#!/bin/fish

if string match '*kitty' $TERM --quiet
    ~/.config/lingshin/scripts/tools/random.fish ~/.config/lingshin/fastfetch-icons
else
    echo hello
end
