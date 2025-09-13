#!/bin/fish

set monitors (niri msg --json focused-output | jq -r .name)
set transparent ~/.config/lingshin/wallpaper/transparent.png

if not pgrep -x swww-daemon >/dev/null
  swww-daemon &
  swww-daemon -n workspace &
  while not swww img $transparent  -n workspace
    sleep 0.1
  end
end

for monitor in $monitors
  set random (randir ~/.config/lingshin/wallpaper/$monitor)
  swww img "$random" --transition-type wipe --outputs "$monitor" --transition-fps 60 --transition-angle 340
end

set toggle ~/.config/lingshin/scripts/swww/toggle.sh
niri msg --json event-stream | while read event
  echo $event | jq .OverviewOpenedOrClosed.is_open | rg -q false
  and $toggle off
end
