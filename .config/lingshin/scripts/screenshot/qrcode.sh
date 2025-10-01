#!/bin/fish

grim -g (slurp) (push)
set output (string split : (zbarimg (top) -q))[2..]
if string match --quiet 'http*' -- "$output"
  firefox $output
else if test -n "$output"
  notify-send "QRCode copied" "$output"
  wl-copy -- $output
end
