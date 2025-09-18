#!/bin/fish

set monitor (niri msg --json focused-output | jq -r .name)

grim -o "$monitor" -t ppm - | satty --filename - --fullscreen --output-filename "$HOME/Pictures/Screenshot/satty-$(date '+%Y%m%d-%H:%M:%S').png" --copy-command=wl-copy
