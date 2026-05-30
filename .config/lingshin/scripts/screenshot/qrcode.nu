#!/usr/bin/env -S nu -n --no-std-lib

def main [] {
  ^grim -g (^slurp) -
  | zbarimg -q - 
  | str replace --regex "^QR-Code:" ""
  | let result
  if $result =~ "^https?://" {
    start $result
  } else if ($result | is-not-empty ) {
    ^notify-send -- "QRCode copied" $result
    ^wl-copy -- $result
  }
}
