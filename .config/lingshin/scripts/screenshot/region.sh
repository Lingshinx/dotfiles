grim -g "$(slurp -c \#ffffffff)" -t ppm - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png --copy-command=wl-copy
