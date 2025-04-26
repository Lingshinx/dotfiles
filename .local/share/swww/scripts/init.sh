wallpapers=$(find ~/Pictures/wallpaper/blue -type f | shuf -n 1)

alias getPos='~/.local/share/swww/scripts/cursor.js'
alias swww='swww img --transition-fps 60 -t grow'

swww "$wallpapers" $(getPos)
