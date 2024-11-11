import { memory } from "./memory.js"
import { hyprland } from "./workspace.js"
import { volumeIndicator } from "./audio.js"
import { NetworkIndicator } from "./network.js"
import { icon, workspaces, focusedTitle } from "./workspace.js"
import { Tray } from "./tray.js"
import { BarClock } from "./clock.js"
import { powerButton } from "./menu-button.js"

const leftContent = Widget.Box({
  children: [icon, workspaces(), focusedTitle],
  className: "leftBar"
})

const centerContent = Widget.Box({
  children: [],
  className: "centerBar"
})

const rightContent = Widget.Box({
  children: [
    Widget.Box({ hexpand: true, }),
    memory,
    NetworkIndicator(),
    volumeIndicator,
    Tray(),
    BarClock,
    powerButton,
  ],
  className: "rightBar"
})

const barContent = Widget.CenterBox({
  startWidget: leftContent,
  center_widget: centerContent,
  endWidget: rightContent,
  className: "containerBar"
})

export const bar = Widget.Window({
  name: 'topbar',
  keymode: 'on-demand',
  // monitor
  anchor: ["right", "top", "left"],
  focusable: true,
  exclusivity: "exclusive",
  child: barContent,
  setup: self => self
    .on("show", self => {
      if (hyprland.active.monitor.id === 0) {
        self.anchor = ["right", "bottom", "left"]
      } else
        self.anchor = ["right", "top", "left"]
    })
})
