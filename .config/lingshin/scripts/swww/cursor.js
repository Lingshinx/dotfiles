#!/bin/node

import { execSync } from 'child_process';

const pos = execSync('hyprctl cursorpos').toString()
const monitor = JSON.parse(
  execSync('hyprctl monitors -j').toString()
).find(monitor => monitor.focused === true);

const height = monitor.height;
const monix = monitor.x;
const moniy = monitor.y;
const scale = monitor.scale;

const pos_x_raw = parseInt(pos.split(',')[0]) - monix;
const pos_y_raw = parseInt(pos.split(',')[1]) - moniy;

const pos_x = Math.round(pos_x_raw * scale)
const pos_y = Math.round(height - pos_y_raw * scale)

console.log(`-o ${monitor.name} --transition-pos ${pos_x},${pos_y}`);
