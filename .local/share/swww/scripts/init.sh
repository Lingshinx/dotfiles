monitors=$(hyprctl monitors -j | jq -r '.[] | .name')
echo "$monitors" | while read -r line; do
  swww img --transition-fps 60 -t grow ~/.config/lingshin/wallpaper/"$line".png -o "line"
done
