const SystemTray = await Service.import('systemtray')
const { Box, Icon, Button } = Widget;
const { Gravity } = imports.gi.Gdk;

const SysTrayItem = (item) => Button({
  className: "tray-item",
  child: Icon({ hpack: 'center' }).bind('icon', item, 'icon'),
  setup: (self) => self
    .hook(item, (self) => self.tooltip_markup = item['tooltip-markup'])
  ,
  onPrimaryClick: (_, event) => item.activate(event),
  onSecondaryClick: (btn, event) => item.menu.popup_at_pointer(null),
});

export const Tray = (props = {}) => {
  const trayContent = Box({
    className: "tool tray",
    setup: (self) => self
      .hook(SystemTray, (self) => {
        self.children = SystemTray.items.map(SysTrayItem);
        self.show_all();
      })
    ,
  });
  const trayRevealer = Widget.Revealer({
    revealChild: true,
    transition: 'slide_left',
    // transitionDuration: userOptions.animations.durationLarge,
    child: trayContent,
  });
  return Box({
    ...props,
    children: [trayRevealer],
  });
}
