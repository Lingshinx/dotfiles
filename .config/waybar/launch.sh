theme=$(~/.config/lingshin/settings/waybar/theme.sh)
monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
dir=~/.config/waybar

echo "{ \"output\": \"$monitor\" }" >$dir/monitor.jsonc

config=$dir/theme/$theme/config.jsonc

ln -s $dir/theme/"$theme"/dark.css $dir/style-dark.css -f
ln -s $dir/theme/"$theme"/light.css $dir/style-light.css -f
ln -s $dir/theme/"$theme"/style.css $dir/base.css -f

killall waybar
pkill waybar

LANG=en_US.UTF-8 waybar -c "$config"
