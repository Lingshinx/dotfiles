#!/bin/fish

set lingshin ~/.config/lingshin
set monitor (hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
set wallpaper_dir $lingshin/wallpaper/$monitor

$lingshin/scripts/swww/switch.sh (randir $wallpaper_dir) --outputs $monitor
