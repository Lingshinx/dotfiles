#!/bin/bash

echo
kitten icat ~/.config/waybar/assets/load-arrow.png

https_proxy=http://127.0.0.1:7890 \
  http_proxy=http://127.0.0.1:7890 \
  all_proxy=socks5://127.0.0.1:7890 \
  yay
