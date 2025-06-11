grim -g "$(slurp -c \#ffffffff)" -t ppm - | satty --filename - --output-filename "$HOME/Pictures/Screenshot/satty-$(date '+%Y%m%d-%H:%M:%S').png" --copy-command=wl-copy
