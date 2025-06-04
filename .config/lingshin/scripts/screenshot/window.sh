at=$(hyprctl activewindow -j | jq '.at' | tr '\n,' ' ' | awk '{print $2","$3}')
size=$(hyprctl activewindow -j | jq '.size' | tr '\n,' ' ' | awk '{print $2"x"$3}')

grim -g "$at $size" -t ppm - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png --copy-command=wl-copy
