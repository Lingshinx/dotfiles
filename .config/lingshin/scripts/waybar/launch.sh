#!/bin/fish

set dir ~/.config/waybar

set cur_monitor (hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
set way_monitor (jq -r .output < $dir/monitor.jsonc)

not pkill waybar || not test $cur_monitor = $way_monitor && begin
  echo '{ "output": "'$cur_monitor'" }' >$dir/monitor.jsonc

  set theme (cat ~/.config/lingshin/settings/waybar/theme)

  ln -fs $dir/theme/$theme/dark.css $dir/style-dark.css
  ln -fs $dir/theme/$theme/light.css $dir/style-light.css
  ln -fs $dir/theme/$theme/style.css $dir/base.css

  set config $dir/theme/$theme/config.jsonc
  LANG=en_US.UTF-8 waybar -c $config
end
