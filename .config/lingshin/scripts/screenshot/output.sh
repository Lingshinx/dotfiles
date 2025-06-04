monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

grim -o "$monitor" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png --copy-command=wl-copy
