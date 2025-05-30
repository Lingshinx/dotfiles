#!/bin/fish

set libraryThumbName "library_600x900.jpg"
set launcherConfig ~/.config/rofi/game/gamelauncher_4.rasi
set steamLib ~/.local/share/Steam/config/libraryfolders.vdf
set steamThumb ~/.local/share/Steam/appcache/librarycache

set manifestList (
  rg path $steamLib | awk -F '"' '{print $4}' | while read sp
     fd 'appmanifest_.*\.acf' $sp --type file 2>/dev/null
  end
)

if test -z "$manifestList"
    notify-send -a HyDE "Cannot Fetch Steam Games!" && exit 1
end

set games (
  for manifest in $manifestList
    set appid (rg appid $manifest | cut -d '"' -f 4)
    set name (rg name $manifest | cut -d '"' -f 4)

    if ! string match --regex --quiet '.*(Proton|Steam).*' $name
       echo "$name|$appid"
    end
  end
)

set choosenGame (
  for game in $games
      set appid (echo $game | cut -d '|' -f 2)
      set name (echo $game | cut -d '|' -f 1)

      set image (fd $libraryThumbName --type file $steamThumb/$appid | head -1)
      printf  "%s\x00icon\x1f$image\n" $name
  end | rofi -dmenu \
      -config $launcherConfig
)

if test -n $choosenGame
    set launchId (printf %s\n $games | rg $choosenGame | cut -d '|' -f 2)
    echo $launchId
    set headerImage (fd ".*header.jpg" "$steamThumb/$launchId/" --type file)

    steam -applaunch "$launchId [gamemoderun %command%]" &
    notify-send -a "HyDE Alert" -i "$headerImage" "Launching $choosenGame..."
end
