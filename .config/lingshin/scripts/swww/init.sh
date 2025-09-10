#!/bin/bash

monitors=$(hyprctl monitors -j | jq -r ".[] | .name")

for monitor in $monitors
  set random (ramdir ~/.config/lingshin/wallpaper/$monitor)
  swww img "$random" --transition-type wipe --outputs "$monitor" --transition-fps 60 --transition-angle 340
done
