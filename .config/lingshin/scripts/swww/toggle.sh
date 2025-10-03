#!/bin/fish

set cache_dir (md ~/.cache/lingshin/niri-swww)
set cur_output (niri msg --json focused-output | jq -r .name)
set cur_wallpaper (randir --current ~/.config/lingshin/wallpaper/$cur_output)
set blurred_img $cache_dir/(basename $cur_wallpaper)
set transparent ~/.config/lingshin/wallpaper/transparent.png
set swww_argu --transition-type none --outputs $cur_output

if test "$argv[1]" = on
  if test -f $blurred_img
    swww img $swww_argu $cur_wallpaper  -n workspace # 工作区使用当前壁纸
    swww img $swww_argu $blurred_img                 # 总览区使用模糊壁纸
  else
    pgrep -x magick
    or magick $cur_wallpaper -gaussian-blur 0x10 $blurred_img
  end
else
  swww img $swww_argu $cur_wallpaper                 # 总览区使用当前壁纸
  swww img $swww_argu $transparent -n workspace      # 工作区使用透明壁纸
end
