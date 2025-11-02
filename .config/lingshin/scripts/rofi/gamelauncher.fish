#!/bin/fish

set libraryThumbName 'library_(600x900.*|capsule)\.jpg'
set launcherConfig ~/.config/rofi/game/gamelauncher_4.rasi
set steamLib ~/.local/share/Steam/config/libraryfolders.vdf
set steamThumb ~/.local/share/Steam/appcache/librarycache

set manifestList (
  rg path $steamLib | choose -f \" 3 | while read sp
     fd 'appmanifest_.*\.acf$' $sp --type file 2>/dev/null
  end
)

test -z "$manifestList"
and notify-send -a HyDE "Cannot Fetch Steam Games!" 
and exit 1

set games (
  for manifest in $manifestList
    set appid (rg '"appid"' $manifest | choose -f \" 3)
    set name (rg name $manifest | choose -f \" 3)

    string match --regex 'Proton|Steam' --quiet $name
    or echo "$name|$appid"
  end
)

for game in $games
    string split '|' $game | read --line name appid

    set image (fd $libraryThumbName --type file $steamThumb/$appid | head -1)
    printf "%s\x00icon\x1f%s\n" $name $image
end | rofi -dmenu \
    -config $launcherConfig | read choosenGame

test -z "$choosenGame"
and exit 1

set launchId (printf %s\n $games | rg $choosenGame | choose -f '|' 1)
set headerImage (fd ".*header.jpg" --type file $steamThumb/$launchId)

notify-send -a Steam -i "$headerImage" "Launching $choosenGame..."
steam -applaunch "$launchId [gamemoderun %command%]" -silent
