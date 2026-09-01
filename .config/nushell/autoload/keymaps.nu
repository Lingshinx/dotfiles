$env.config.edit_mode = 'vi'

$env.config.keybindings ++= [
  {
    name: commandline_copy
    modifier: control
    keycode: char_x
    mode: [emacs vi_insert]
    event: {
      send: ExecuteHostCommand
      cmd: "use std/clip; commandline | clip copy52"
    }
  }
  {
    name: prefix_sudo
    modifier: control
    keycode: char_s
    mode: [emacs vi_insert]
    event: {
      send: ExecuteHostCommand
      cmd: "let cmd = (commandline); commandline edit (if $cmd starts-with sudo { $cmd | str replace -r '^sudo ' '' } else { 'sudo ' ++ $cmd })"
    }
  }
]
