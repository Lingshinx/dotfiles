#!/bin/bash

active=$(hyprctl activewindow)
if test "$active" != "Invalid"; then
  exit 0
fi

monitors=$(hyprctl monitors -j | jq -r '.[] | .name')
echo "$monitors" | while read -r line; do
  random="$(~/.config/lingshin/scripts/tools/random.fish ~/.config/lingshin/wallpaper/random)"
  swww img "$random" -type wipe --output "$line" --transition-fps 60 --transition-angle 340
done
