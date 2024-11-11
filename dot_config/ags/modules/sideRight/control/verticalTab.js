
const { FlowBox, Box, Label, Button, Stack } = Widget

export function Tab({ name, icon, color }) {
  return FlowBox({
    css: `color:${color}`
  });
}
