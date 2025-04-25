if pgrep -x "nm-applet" >/dev/null; then
  echo "Running"
  killall nm-applet
else
  echo "Stopped"
  nm-applet --indicator &
fi
