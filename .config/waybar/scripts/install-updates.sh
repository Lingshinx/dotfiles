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

yay
