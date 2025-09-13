#!/bin/fish

set lingshin ~/.config/lingshin
set monitor (niri msg --json focused-output | jq -r .name)
set wallpaper_dir $lingshin/wallpaper/$monitor/

$lingshin/scripts/swww/switch.sh (randir $wallpaper_dir) --outputs $monitor
