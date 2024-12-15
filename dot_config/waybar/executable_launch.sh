theme=$(~/.config/lingshin/settings/waybar/theme.sh)
dir=~/.config/waybar

config=$dir/theme/$theme/config.jsonc

rm $dir/*.css
ln -s $dir/theme/$theme/dark.css $dir/style-dark.css
ln -s $dir/theme/$theme/light.css $dir/style-light.css
ln -s $dir/theme/$theme/style.css $dir/base.css

killall waybar
pkill waybar

waybar -c "$config"
