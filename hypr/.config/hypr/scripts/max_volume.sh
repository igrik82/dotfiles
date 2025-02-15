#!/usr/bin/env bash
current=$(pactl list sinks | awk 'NR==10, /%/ {print $5}' | cut -d "%" -f 1)
[ $current -lt 100 ] && pactl set-sink-volume 0 +5%
[ $current -gt 95 ] && pactl set-sink-volume 0 100%
