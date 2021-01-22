#!/bin/bash

xrandr --newmode 1280x1024_75.00  138.54  1280 1368 1504 1728  1024 1025 1028 1069  -HSync +Vsync
xrandr --newmode 1680x1050_75.00  188.07  1680 1800 1984 2288  1050 1051 1054 1096  -HSync +Vsync
xrandr --addmode $1 1280x1024_75.00
xrandr --addmode $2 1680x1050_75.00
xrandr --output $1 --mode 1280x1024_75.00
xrandr --output $2 --mode 1680x1050_75.00
