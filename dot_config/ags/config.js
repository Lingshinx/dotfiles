import { bar } from "./modules/bar/main.js"
import { sideRight_window } from "./modules/sideRight/main.js"


App.config({
  windows: [
    bar,
    sideRight_window
  ],
  style: './css/config.css'
})
