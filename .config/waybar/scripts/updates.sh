#!/bin/bash

threshhold_green=0
threshhold_yellow=25
threshhold_red=100

check_lock_files() {
  local pacman_lock="/var/lib/pacman/db.lck"
  local checkup_lock="${TMPDIR:-/tmp}/checkup-db-${UID}/db.lck"

  while [ -f "$pacman_lock" ] || [ -f "$checkup_lock" ]; do
    sleep 1
  done
}

check_lock_files

updates=$(checkupdates-with-aur | wc -l)

css_class="green"

if [ "$updates" -gt $threshhold_yellow ]; then
  css_class="yellow"
fi

if [ "$updates" -gt $threshhold_red ]; then
  css_class="red"
fi

if [ "$updates" -gt $threshhold_green ]; then
  printf '{"text": "  %s", "alt": "%s", "tooltip": "Click to update your system", "class": "%s"}' "$updates" "$updates" "$css_class"
else
  printf '{"text": "", "alt": "0", "tooltip": "No updates available", "class": "hidden"}'
fi
