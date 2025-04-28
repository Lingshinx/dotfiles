#!/bin/bash
lingshin=~/.config/lingshin
list_f="$lingshin"/scripts/swww/list
index_f="$lingshin"/scripts/swww/index
index=$(cat "$index_f")

wallpaperpaper=$(sed -n "$index"p "$list_f")
"$lingshin"/scripts/swww/switch.sh "$wallpaperpaper"

if [ "$index" = 1 ]; then
  list=$(find "$lingshin"/wallpaper/random/ -type f)
  echo "$list" | shuf >"$list_f"
  echo "$list" | wc -l >"$index_f"
else
  echo $((index - 1)) >"$index_f"
fi
