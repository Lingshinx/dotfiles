import { Tab } from "./verticalTab.js"

const { Box, Label, Button, Stack } = Widget

const modules = [
  {
    name: 'notification',
    icon: ' ',
    color: 'text',
    content: Box(),
  }, {
    name: 'wifi',
    icon: '󰖩 ',
    color: 'green',
    content: Box(),
  }, {
    name: 'bluetooth',
    icon: '󰂯',
    color: 'blue',
    content: Box(),
  }
]

export const controlCenter = Box({

})

export const verticalTab = Box({
  className: "vertical-tab",
  vertical: true,
  children: modules.map(Tab)
})

