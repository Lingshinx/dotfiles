#!/bin/bash

lingshin=~/.config/lingshin
monitor="$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')"
wallpaper_dir="$lingshin/wallpaper/$monitor/"

$lingshin/scripts/swww/switch.sh "$($lingshin/scripts/tools/random.fish "$wallpaper_dir")" --outputs $monitor
