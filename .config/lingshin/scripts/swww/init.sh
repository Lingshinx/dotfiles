#!/bin/bash

id=$(hyprctl activewindow -j | jq '.workspace.id')
if test "$id" != null; then
  active_monitor=$(hyprctl workspaces -j | jq -r ".[] | select(.id == $id) | .monitor")
fi

monitors=$(hyprctl monitors -j | jq -r ".[] | select(.name != \"$active_monitor\") | .name")

if test -z "$monitors"; then
  exit
fi

echo "$monitors" | while read -r line; do
  random="$(~/.config/lingshin/scripts/tools/random.fish ~/.config/lingshin/wallpaper/random)"
  swww img "$random" --transition-type wipe --outputs "$line" --transition-fps 60 --transition-angle 340
done
