#!/bin/bash

monitors=$(hyprctl monitors -j | jq -r ".[] | .name")

echo "$monitors" | while read -r line; do
  random="$(~/.config/lingshin/scripts/tools/random.fish ~/.config/lingshin/wallpaper/random)"
  swww img "$random" --transition-type wipe --outputs "$line" --transition-fps 60 --transition-angle 340
done
