#!/bin/bash

pid=$(pgrep --full '^wlogout$')
if [[ -n $pid ]]; then
  kill $pid
else
  wlogout
fi
