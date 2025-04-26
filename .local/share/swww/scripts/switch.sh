wallpapers=$1

alias getPos='~/.local/share/swww/scripts/cursor.js'
alias swww='swww img --transition-fps 60 -t grow'

swww "$wallpapers" $(getPos)
