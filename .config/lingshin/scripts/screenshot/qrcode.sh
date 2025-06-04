#!/bin/bash
tempfile=$(mktemp)
grim -g "$(slurp)" $tempfile
output="$(zbarimg $tempfile -q)"
if [[ -n $output ]]; then
  zen "${output#*:}"
fi
