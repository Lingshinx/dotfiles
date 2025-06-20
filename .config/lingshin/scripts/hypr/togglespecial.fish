#!/bin/fish

set motion $argv[1]

test special:magic = (hyprctl activewindow -j | jq -r .workspace.name) &&
    hyprctl dispatch $motion +0 ||
    hyprctl dispatch $motion special:magic
