const { GLib } = imports.gi;
export const BarClock = Widget.Label({
  className: 'tool clock',
  label: GLib.DateTime.new_now_local().format("  %H:%M"),
  setup: (self) => {
    self.poll(3000, label => {
      label.label = GLib.DateTime.new_now_local().format("  %H:%M") || "error";
    })
    self.tooltip_text = GLib.DateTime.new_now_local().format("  %a, %d %b") || "error";//   {:%a,%d %b}
  },
})
// Widget.Label({
//   // className: 'txt-norm txt-onLayer1',
//   label: '•',
// }),
// Widget.Label({
//   // className: 'txt-smallie bar-date',
//   label: GLib.DateTime.new_now_local().format(userOptions.time.dateFormatLong),
//   setup: (self) => self.poll(userOptions.time.dateInterval, (label) => {
//     label.label = GLib.DateTime.new_now_local().format(userOptions.time.dateFormatLong);
//   }),
// }),
