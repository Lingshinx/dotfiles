#!/usr/bin/env -S nu -n --no-std-lib

def main [] {
  ^grim -g (^slurp -c "#ffffffff") -t ppm - 
  | (^satty
    --filename -
    --output-filename ~/Pictures/Screenshot/satty-(date now | format date '%Y%m%d-%H:%M:%S').png 
    --copy-command=wl-copy
  )
}


