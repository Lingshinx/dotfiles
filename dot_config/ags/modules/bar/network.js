const network = await Service.import('network')

const WifiIndicator = () => Widget.Box({
  children: [
    Widget.Icon({
      icon: network.wifi.bind('icon_name'),
    }),
    Widget.Label({
      label: network.wifi.bind("strength").as(it => `  ${it.toString()}%`)
      // .as(ssid => ssid || 'Unknown'),
    }),
  ],
  className: "tool wifi",
})

const Disconnectted = () => Widget.Label({
  label: "  OFF",
  className: "tool disconnected"
})

const Connecting = () => Widget.Label({
  label: "  ing",
  className: "tool connecting"
})

const WiredIndicator = () => Widget.Label({
  label: " .net",
  className: "tool connecting"
})

const shown = Utils.merge([network.bind("primary"), network.wifi.bind("internet")], (primary, internet) => (primary === "wifi") ? internet : "wired")

export const NetworkIndicator = () => Widget.Stack({
  shown,
  transition: "slide_right",
  children: {
    disconnected: Disconnectted(),
    connected: WifiIndicator(),
    connecting: Connecting(),
    wired: WiredIndicator(),
  },
  setup: (self) => {
    self.tooltip_text = network.wifi.ssid
  }
})
