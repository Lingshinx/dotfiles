// BarResource('RAM Usage', 'memory', `LANG=C free | awk '/^Mem/ {printf("%.2f\\n", ($3/$2) * 100)}'`,
//     'bar-ram-circprog', 'bar-ram-txt', 'bar-ram-icon'),


export const memory = Widget.Label({
  className: "tool memory",
  setup: (self) => {
    self.poll(5000, () => {
      Utils.execAsync(["bash", "-c", `LANG=C free | awk '/^Mem/ {printf("%.2f\\n", ($3/1048576))}'`])
        .then(output => {
          memory.label = ` ${output}G`
        }).catch(print)
    })
  }
}) 
