#!/bin/fish

switch $argv[2]
    case l
        set direction -$argv[1] 0
    case r
        set direction $argv[1] 0
    case u
        set direction 0 -$argv[1]
    case d
        set direction 0 $argv[1]
end

while true
    ydotool mousemove -- $direction
    sleep 0.01
end
