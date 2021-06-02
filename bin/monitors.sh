#!/bin/sh

# HP monitor fix
xrandr --newmode "1280x1024_70.00"  109.00  1280 1368 1496 1712  1024 1027 1034 1063 -hsync +vsync
xrandr --addmode VGA-1-1 "1280x1024_70.00"
xrandr --output VGA-1-1 --mode "1280x1024_70.00" --left-of VGA-0

xrandr --output VGA-0 --primary --mode 1680x1050 --pos 1280x0 --rotate normal --output DVI-D-0 --off --output HDMI-0 --mode 1280x1024 --pos 2960x0 --rotate normal --output VGA-1-1 --mode 1280x1024_70.00 --pos 0x0 --rotate normal --output HDMI-1-1 --off
