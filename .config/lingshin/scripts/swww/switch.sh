#!/bin/fish

swww img --transition-fps 60 -t grow $argv[1] -o (niri msg --json focused-output | jq -r .name)
