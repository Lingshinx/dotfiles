$env.config.edit_mode = 'vi'

$env.config.keybindings ++= [{
	name: commandline_copy
	modifier: control
	keycode: char_x
	mode: [emacs vi_insert]
	event: {
		send: ExecuteHostCommand
		cmd: "use std/clip; commandline | clip copy"
	}
}]
