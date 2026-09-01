#!/usr/bin/env -S nu -n --no-std-lib

use wpctl.nu

export def main [] {}

def link-rl [
  output: string
  input: string
  --disconnect (-d)
] {
  let $disconnect = [(if $disconnect { "--disconnect" })] | compact
  try { ^pw-link ...$disconnect ($output)_FR ($input)_FR }
  try { ^pw-link ...$disconnect ($output)_FL ($input)_FL }
}

export def "main lien-shien" [] {
  const sunshine = "sink-sunshine-stereo"
  const headset_playback = "alsa_output.usb-EDIFIER_Technology________Doo_Ace_4150345A39303901-00.analog-stereo:playback"
  const mumble_output = "Playback:output"
  ^wpctl set-default (wpctl list | where name == "sink-sunshine-stereo" | first).id
  link-rl ($sunshine):monitor ($headset_playback)
  link-rl -d ($mumble_output) ($sunshine):playback
  link-rl ($mumble_output) ($headset_playback)
  link-rl ($sunshine):monitor sunshine:input
}
