#!/usr/bin/env -S nu -n --no-std-lib

def main [] {
  let temp = mktemp
  ^niri msg action screenshot-window --path $temp
  ^inotifywait --event close --timeout 2 $temp
  if $env.LAST_EXIT_CODE == 0 and (^wl-paste -l | lines | any {|it| $it =~ "^image/"}) {
    ^wl-paste
    | (^satty
      --resize smart
      --filename -
      --output-filename ~/Pictures/Screenshot/satty-(date now | format date '%Y%m%d-%H:%M:%S').png
      --copy-command=wl-copy)
  }
}
