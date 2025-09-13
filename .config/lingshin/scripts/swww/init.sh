#!/bin/fish

for monitor in (niri msg --json focused-output | jq -r .name)
  set random (randir ~/.config/lingshin/wallpaper/$monitor)
  swww img "$random" --transition-type wipe --outputs "$monitor" --transition-fps 60 --transition-angle 340
end
