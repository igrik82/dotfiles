#!/usr/bin/env bash

# DIR=/home/igrik/Pictures/Wallpapers
DIR=/home/igrik/Pictures/Wallpapers_work
PICS=$(ls ${DIR})
RANDOMPICS=$(/usr/bin/shuf -e $PICS -n 1)

if [[ $(pidof swaybg) ]]; then
  pkill swaybg
fi

swww query || swww init

#change-wallpaper using swww
swww img ${DIR}/${RANDOMPICS} --transition-fps 30 --transition-type random --transition-duration 3
