const application = await Service.import("applications")
const window_name = 'applauncher'

const { Box, Label, Icon } = Widget

export const searchBar = Box({
  className: "search-bar",
  children: [
    Label({
      className: "search-Icon",
      label: ' ',
    }),
    Label(),
  ]
}) 
