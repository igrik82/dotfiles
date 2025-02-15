#!/bin/sh
#  ___    _ _      _   _
# |_ _|__| | | ___| |_(_)_ __ ___   ___
#  | |/ _` | |/ _ \ __| | '_ ` _ \ / _ \
#  | | (_| | |  __/ |_| | | | | | |  __/
# |___\__,_|_|\___|\__|_|_| |_| |_|\___|
#
#
# by Stephan Raabe (2023)
# -----------------------------------------------------

LOCKSCREEN=1200
DISPLAYOFF=1500
SUSPEND=2400

if [ -f "/usr/bin/swayidle" ]; then
  echo "swayidle is installed."
  swayidle -w timeout $LOCKSCREEN 'swaylock -f' \
    timeout $DISPLAYOFF 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' \
    timeout $SUSPEND 'systemctl suspend'
else
  echo "swayidle not installed."
fi
