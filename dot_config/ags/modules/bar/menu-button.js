import { name } from "../sideRight/main.js"

const powerIcon = Widget.Label({
  label: "󱅰",
  css: "font-size : 20px;"
})

// "on-click": "hyprctl dispatch exit",
// "format": "⏻ ",
export const powerButton = Widget.Button({
  child: powerIcon,
  className: "tool menu",
  onClicked: () => {
    App.toggleWindow(name)
  }
})
