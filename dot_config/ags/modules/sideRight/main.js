import { hyprland } from "../service.js";
import { sideRight } from "./sidebarRight.js"

export { name, sideRight_window }

const name = 'sideRight';

const { Window, Box, EventBox } = Widget

const clickCloseRegion = EventBox({
  child: Box({
    expand: true,
    css: `
      min-width:${hyprland.monitors[0].width}px;
      background-color:transparent;
    `,
  }),
  setup: (self) => self.on('button-press-event', (self, event) => {
    App.closeWindow(name)
  })
})

const sideRight_window = Window({
  name,
  visible: false,
  layer: "top",
  anchor: ['right', 'top', 'bottom'],
  keymode: 'on-demand',
  child: Box({
    children: [clickCloseRegion, sideRight],
  }),
  css: `
      background-color:transparent;
  `,
  setup: (self) => {
    self.keybind("Escape", () => App.closeWindow(name))
  }
})
