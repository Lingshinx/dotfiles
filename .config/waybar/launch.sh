theme=$(~/.config/lingshin/settings/waybar/theme.sh)
monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
dir=~/.config/waybar

echo "{ \"output\": \"$monitor\" }" >$dir/monitor.jsonc

config=$dir/theme/$theme/config.jsonc

rm $dir/*.css
ln -s $dir/theme/"$theme"/dark.css $dir/style-dark.css
ln -s $dir/theme/"$theme"/light.css $dir/style-light.css
ln -s $dir/theme/"$theme"/style.css $dir/base.css

killall waybar
pkill waybar

waybar -c "$config"
