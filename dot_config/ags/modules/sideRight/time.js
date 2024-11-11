const { Label } = Widget
const { execAsync } = Utils
export const upTime = Label({
  hpack: 'center',
  className: 'timeRow-text',
  setup: self => {
    const getUptime = async () => {
      try {
        await execAsync(['bash', '-c', 'uptime -p'])
        return execAsync(['bash', '-c', `uptime -p | sed -e 's/...//;s/ day\\| days/d/;s/ hour\\| hours/h/;s/ minute\\| minutes/m/;s/,[^,]*//2'`])
      } catch {
        return execAsync(['bash', '-c', 'uptime']).then(output => {
          const uptimeRegex = /up\s+((\d+)\s+days?,\s+)?((\d+):(\d+)),/
          const matches = uptimeRegex.exec(output)

          if (matches) {
            const days = matches[2] ? parseInt(matches[2]) : 0;
            const hours = matches[4] ? parseInt(matches[4]) : 0;
            const minutes = matches[5] ? parseInt(matches[5]) : 0;

            let formattedUptime = '';

            if (days > 0) {
              formattedUptime += `${days} d `;
            }
            if (hours > 0) {
              formattedUptime += `${hours} h `;
            }
            formattedUptime += `${minutes} m`;
            return formattedUptime;
          } else {
            throw new Error('Failed to parse uptime output');
          }
        })
      }
    }

    self.poll(5000, label => {
      getUptime().then(upTimeString => {
        label.label = `Uptime: ${upTimeString}`
      }).catch(err => {
        console.error(err)
      })
    })
  }
})
