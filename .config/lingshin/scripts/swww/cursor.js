#!/bin/node

import { execSync } from "child_process";

const pos = execSync("hyprctl cursorpos")
  .toString()
  .split(",")
  .map((x) => parseInt(x));
const monitor = JSON.parse(execSync("hyprctl monitors -j").toString()).find(
  (monitor) => monitor.focused === true,
);

const { width, height, x, y, scale, transform } = monitor;

const pos_x_raw = pos[0] - x;
const pos_y_raw = pos[1] - y;
const even = (x) => x % 2 == 0;
const real_height = even(transform) ? height : width;
const pos_x = Math.round(pos_x_raw * scale);
const pos_y = Math.round(real_height - pos_y_raw * scale);

console.log(`-o ${monitor.name} --transition-pos ${pos_x},${pos_y}`);
