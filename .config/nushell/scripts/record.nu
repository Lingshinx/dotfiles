#!/usr/bin/env -S nu -n --no-std-lib

# screcord

# Record wayland screen with wf-recorder
@search-terms screen record
@example "Record current output and save to `/tmp`" { record.sh } --result /tmp/tmp.qanS5uvJeT/screen-record.mp4
@example "Record DP-1 and save to `~/Videos/Screen-record`" { record.sh -s -o DP-1 } --result /home/username/Videos/Screen-record/2026/04.19-14:12-screen-record.mp4
@example "Record a region with 3 seconds delay" { record.sh -d 3sec } --result /tmp/tmp.VrtJxgge6g/screen-record.mp4
export def main [
  --mute (-m)   # Record without audio device
  --save (-s)   # Save to ~/Videos/Screen-record
  --region (-r) # Select a region to record
  --copy (-c)   # Copy after recording
  --output (-o): string # Record a output (default to focused output)
  --delay (-d): duration # Delay before recording
  name: string = screen-record # Name of file without extension
]: nothing -> path {
  let filename = $'($name).mp4'
  let mute = if not $mute {
    '-a'
  }
  let save = if $save {
    $'~/Videos/Screen-record/(date now | format date %Y/%m.%d-%H:%M)-($filename)' | path expand
  } else {
    mktemp --directory | path join $filename
  }
  let output = $output | default (^niri msg --json focused-output | from json).name
  let region = if $region {
    [--geometry (^slurp)]
  } else {
    [--output $output]
  }
  let args = [-f $save $mute ...$region] | compact

  mkdir ($save | path dirname)
  if ($delay | is-not-empty) {
    sleep $delay
  }
  let job = job spawn {
    ^wf-recorder --overwrite ...$args
    job send 0
  }
  let is_out_tty = is-terminal --stdout 
  if $is_out_tty {
    print -e $"\n(ansi yellow)  press any key to quit:"
    print -en $"(ansi green)❯ (ansi reset)"
  }
  input --numchar 1
  job list | where id == $job | get -o 0.pids | kill -s 15 ...$in
  job recv

  if $copy {
    ^fcp $save
    if $is_out_tty {
      print -en $"(ansi cyan_bold)($save)(ansi reset) Copied"
    }
  } else {
    if $is_out_tty {
      print -en $"Saved to (ansi cyan_bold)($save)(ansi reset)"
    } else {
      $save
    }
  }
}
