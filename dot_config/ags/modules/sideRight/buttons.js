import { setupCursorHover } from "../cursorhover.js"

const { execAsync, exec } = Utils
const { Label, Box, Icon, Button } = Widget

const Command = {
  reload: 'hyprctl reload',
  setting: 'XDG_CURRENT_DESKTOP="gnome" gnome-control-center',
  exit: 'wlogout'
}

export const avatar = Box({
  className: 'timeRow-avatar',
})

export const ReloadIcon = Button({
  hpack: 'end',
  tooltipText: 'Reload',
  className: 'reload timeRow-button',
  // child: Icon('system-reboot'),
  child: Label(''),
  onClicked: () => {
    execAsync(['bash', '-c', Command.reload])
    App.closeWindow('sideRight')
  },
  setup: button => {
    setupCursorHover(button)
  }
})

export const SettingIcon = Button({
  hpack: 'end',
  className: 'setting timeRow-button',
  tooltipText: 'setting',
  child: Label(''),
  onClicked: () => {
    execAsync(['bash', '-c', Command.setting])
    App.closeWindow('sideRight')
  },
  setup: button => {
    setupCursorHover(button)
  }
})

export const PowerIcon = Button({
  hpack: 'end',
  className: 'power timeRow-button',
  tooltipText: 'power',
  child: Label('⏻'),
  onClicked: () => {
    App.closeWindow('sideRight')
    execAsync(['bash', '-c', Command.exit])
  }
})
