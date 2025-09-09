#!/bin/fish

set monitors (niri msg --json focused-output | jq -r .name)

for monitor in $monitors
  set random (randir ~/.config/lingshin/wallpaper/$monitor)
  swww img "$random" --transition-type wipe --outputs "$monitor" --transition-fps 60 --transition-angle 340
end
