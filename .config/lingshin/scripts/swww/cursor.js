#!/bin/node

import { execSync } from 'child_process';

const pos = execSync('hyprctl cursorpos').toString().split(',').map(x => parseInt(x))
const monitor = JSON.parse(
  execSync('hyprctl monitors -j').toString()
).find(monitor => monitor.focused === true);

const { height, x, y, scale } = monitor

const pos_x_raw = pos[0] - x;
const pos_y_raw = pos[1] - y;

const pos_x = Math.round(pos_x_raw * scale)
const pos_y = Math.round(height - pos_y_raw * scale)

console.log(`-o ${monitor.name} --transition-pos ${pos_x},${pos_y}`);
