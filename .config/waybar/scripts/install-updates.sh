if gum confirm "DO YOU WANT TO START THE UPDATE NOW?"; then
  echo
  echo ":: Update started."
elif [ $? -eq 130 ]; then
  exit 130
else
  echo
  echo ":: Update canceled."
  exit
fi

https_proxy=http://127.0.0.1:7890 \
  http_proxy=http://127.0.0.1:7890 \
  all_proxy=socks5://127.0.0.1:7890 \
  yay
