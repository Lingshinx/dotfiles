#!/bin/bash

lingshin=~/.config/lingshin
cache_dir=~/.cache/lingshin/swww
wallpaper_dir="$lingshin/wallpaper/random/"
list_file="$cache_dir/list"
index_file="$cache_dir/index"

mkdir -p "$cache_dir"

if [ ! -d "$wallpaper_dir" ]; then
  echo "错误: 壁纸目录 '$wallpaper_dir' 不存在"
  exit 1
fi

if [ ! -f "$index_file" ] || [ ! -f "$list_file" ] || [ "$(cat "$index_file" 2>/dev/null || echo 0)" -le 0 ]; then
  wallpaper_list=$(find "$wallpaper_dir" -type f)
  if [ -z "$wallpaper_list" ]; then
    echo "错误: 壁纸目录为空"
    exit 1
  fi
  echo "$wallpaper_list" | shuf >"$list_file"
  wc -l <"$list_file" >"$index_file"
fi

index=$(cat "$index_file")
wallpaper=$(sed -n "${index}p" "$list_file")

"$lingshin/scripts/swww/switch.sh" "$wallpaper"

echo $((index - 1)) >"$index_file"
