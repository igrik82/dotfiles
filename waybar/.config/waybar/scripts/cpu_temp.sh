#!/usr/bin/env bash

for (( ; ; )); do
  TEMP_CPU="$(cat /sys/class/thermal/thermal_zone0/temp)"
  echo "$(echo "$TEMP_CPU / 1000" | bc)"
  sleep 3
done
