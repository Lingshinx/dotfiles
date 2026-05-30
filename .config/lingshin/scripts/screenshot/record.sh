#!/bin/fish

argparse 'o/output=' 'm/mute' 's/save' 'r/region' -- $argv
set filename (default $argv record).mp4
set output (default $_flag_output (niri msg --json focused-output | jq -r .name))

test -n "$_flag_mute"
or set -a cmd_arg -a

test -n "$_flag_save"
and set -a cmd_arg -f ~/Videos/Screen-record/(date +%Y/%m.%d-%H:%M)-$filename.mp4
or set -a cmd_arg -f (push $filename)

if test -n "$_flag_region"
  set -a cmd_arg --geometry (slurp)
else
  set -a cmd_arg --output $output
end

wf-recorder --overwrite $cmd_arg &>/dev/null &
read -sn 1 -p "echo -n 'press any key to quit: '" >/dev/null
kill -15 $last_pid
fcp (pop)
