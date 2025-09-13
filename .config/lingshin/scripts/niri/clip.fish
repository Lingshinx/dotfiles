#!/bin/fish

sleep 0.5

test "$argv" = copy
and ydotool key 29:1 110:1 110:0 29:0 -d 1ms
and exit

test "$argv" = paste
and ydotool key 42:1 110:1 110:0 42:0 -d 1ms
