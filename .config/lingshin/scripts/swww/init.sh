#!/usr/bin/fish

for monitor in (niri msg --json outputs | jq -r '.[] | .name')
  set random (randir ~/.config/lingshin/wallpaper/$monitor)
  awww img "$random" --transition-type wipe --outputs "$monitor" --transition-fps 60 --transition-angle 340
end
