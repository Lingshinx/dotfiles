submap=$(hyprctl submap)
alias setBorder='hyprctl keyword general:col.active_border'
passthruColor="0xeefca7ea 0xee33ccff 45deg"
groupColor="0xeefca7ea 0xee33ccff 45deg"
resizeColor="0xeeaa88ff 0xee7799bb 45deg"
resetColor="0xee33ccff 0xee00ff99 45deg"

if test "$submap" = "default"; then
  hyprctl dispatch submap "$1" -q
  if test "$1" = "Resize"; then
    setBorder "$resizeColor"
  elif test "$1" = "Group"; then
    setBorder "$groupColor"
  elif test "$1" = "Ignore"; then
    setBorder "$passthruColor"
  fi
else
  hyprctl dispatch submap reset -q
  setBorder "$resetColor"
fi
