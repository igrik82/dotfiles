#!/bin/bash

IDLE_TIME=30000 # Время бездействия в миллисекундах (5 минут = 300000 мс)

while true; do
  idle=$(xprintidle) # Получаем время бездействия
  if [ "$idle" -ge "$IDLE_TIME" ]; then
    cmatrix -s # Запускаем cmatrix
    break      # Выходим из цикла после запуска
  fi
  sleep 10 # Проверяем каждые 10 секунд
done
