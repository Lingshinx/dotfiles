#!/bin/fish

switch $argv[1]
    case l
        set direction -1 0
    case r
        set direction 1 0
    case u
        set direction 0 1
    case d
        set direction 0 -1
end

while true
    ydotool mousemove -w -- $direction
    sleep 0.1
end
