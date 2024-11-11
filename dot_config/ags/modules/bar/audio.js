const audio = await Service.import('audio')


const audioIcon = Widget.Icon()
const audioLable = Widget.Label()
export const volumeIndicator = Widget.Button({
  on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
  onScrollUp: () => {
    if (!audio.speaker) return;
    if (audio.speaker.volume <= 0.09) audio.speaker.volume += 0.01;
    else if (audio.speaker.volume >= 0.19) audio.speaker.volume += 0.05;
    else audio.speaker.volume += 0.02;
    // Indicator.popup(1);
  },
  onScrollDown: () => {
    if (!audio.speaker) return;
    if (audio.speaker.volume <= 0.09) audio.speaker.volume -= 0.01;
    else if (audio.speaker.volume >= 0.2) audio.speaker.volume -= 0.05;
    else audio.speaker.volume -= 0.02;
    // Indicator.popup(1);
  },
  className: "tool audio",
  child: Widget.Box({
    children: [
      audioIcon, audioLable
    ]
  }).hook(audio.speaker, self => {
    const vol = Math.ceil(audio.speaker.volume * 100);
    const mapArray = ['muted', 'low', 'medium', 'high', 'overamplified']
    const usingHeadphones = () => (audio.speaker?.stream?.port)?.toLowerCase().includes('head')
    const volume_to_Icon = () => `audio-volume-${mapArray[Math.ceil(vol / 33)]}-symbolic`
    const icon = audio.speaker.is_muted ? 'audio-volume-muted-symbolic' : usingHeadphones() ? 'audio-headset-symbolic' : volume_to_Icon()
    audioIcon.icon = icon
    audioLable.label = ` ${vol}%`
    self.tooltip_text = `${audio.speaker.stream?.description}`
    // self.tooltip_text = `Volume ${Math.floor(vol)}%`;
  }),
})
