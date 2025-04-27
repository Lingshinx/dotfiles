#!/bin/bash
lingshin=~/.config/lingshin
"$lingshin"/scripts/swww/switch.sh $(find "$lingshin"/wallpaper/random/ -type f | shuf -n 1)
