#!/bin/fish

function setBorder
  hyprctl keyword general:col.active_border $argv
end

set Ignore    '0xeefca7ea 0xee33ccff 45deg'
set Group     '0xeefca7ea 0xee33ccff 45deg'
set Resize    '0xeeaa88ff 0xee7799bb 45deg'
set reset     '0xee33ccff 0xee00ff99 45deg'

set mode $argv[1]
if test "$(hyprctl submap)" = $mode
  hyprctl dispatch submap reset -q
  setBorder $reset
  exit
end

setBorder $$mode
hyprctl dispatch submap $mode -q
