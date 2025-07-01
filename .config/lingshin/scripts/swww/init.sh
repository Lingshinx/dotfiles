#!/bin/bash

monitors=$(hyprctl monitors -j | jq -r ".[] | .name")

echo "$monitors" | while read -r monitor; do
  random="$(~/.config/lingshin/scripts/tools/random.fish ~/.config/lingshin/wallpaper/"$monitor")"
  swww img "$random" --transition-type wipe --outputs "$monitor" --transition-fps 60 --transition-angle 340
done
