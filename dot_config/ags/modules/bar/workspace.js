export { focusedTitle, workspaces, icon }

const icon = Widget.Label({
  label: " ",
  className: "workspace icon"
})

export const hyprland = await Service.import('hyprland')

const focusedTitle = Widget.Label({
  label: hyprland.active.client.bind('title').as(title => {
    const maxLength = 50
    if (title.length > maxLength) {
      return title.substring(0, 50) + "..."
    } else {
      return title
    }
  }),
  visible: hyprland.active.client.bind('address').as(addr => !!addr),
  className: "workspace content",
  // maxWidthChars: 10,
  // wrap: true,
})

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`);

const iconMap = ["", "", "", "", "",]
function mapIcon(i) {
  return (i < 5) ? iconMap[i] : ""
}
const workspaces = () => Widget.EventBox({
  onScrollUp: () => dispatch('-1'),
  onScrollDown: () => dispatch('+1'),
  className: "workspaces",
  child: Widget.Box({
    children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
      attribute: i,
      label: `${mapIcon(i - 1)}`,
      onClicked: () => dispatch(i),
      className: "workspace button"
    })),

    // remove this setup hook if you want fixed number of buttons
    setup: self => self.hook(hyprland, () => {
      const id = hyprland.active.workspace.id
      self.children.forEach(btn => {
        const its_ws = hyprland.workspaces.find(ws => ws.id === btn.attribute);
        const not_empty = its_ws && its_ws.windows !== 0
        btn.toggleClassName("active", id === btn.attribute)
        btn.toggleClassName("empty", !not_empty)
        btn.visible = not_empty || btn.attribute <= 4 || btn.attribute <= id
      })
    }),
  })
})

