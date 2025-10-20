#!/bin/fish

grim -g (slurp) (push)
set output (string replace --regex ^QR-Code: '' (zbarimg -q (top)))
echo $output
if string match --quiet 'http*' -- "$output"
  xdg-open $output
else if test -n "$output"
  notify-send "QRCode copied" "$output"
  wl-copy -- $output
end
