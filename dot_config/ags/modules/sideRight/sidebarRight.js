import { avatar, ReloadIcon, SettingIcon, PowerIcon } from './buttons.js'
import { controlCenter } from './control/control-center.js'
import { upTime } from './time.js'
import { verticalTab } from './control/control-center.js'

const { Box, EventBox, Icon, Label, Separator } = Widget

const name = Label({
  hpack: "start",
  className: 'top-name',
  label: 'lingshin'
})

const timeRow = Box({
  className: 'control time',
  hpack: 'center',
  children: [
    upTime,
    Box({ hexpand: true }),
    ReloadIcon,
    SettingIcon,
    PowerIcon,
  ]
})

const topline = Box({
  children: [
    avatar,
    Box({
      vertical: true,
      vpack: "center",
      children: [
        name,
        timeRow,
      ]
    })
  ]
})

export const sideRight = Box({
  hexpand: true,
  children: [
    verticalTab,
    Box({
      className: 'side-right',
      vertical: true,
      vexpand: true,
      children: [
        topline,
        Separator({
          className: 'seperator',
        }),
        Box({
          className: 'notify box',
          children: [
            controlCenter,
          ]
        })
        // ModuleCalender(),
      ]
    })
  ],
});
