#!/usr/bin/env python3
# https://www.reddit.com/r/MiniPCs/comments/18icusg/t9_plus_n100_how_to_control_led/
# import serial.tools.list_ports
import serial.tools.list_ports
import subprocess
import time

# Ищем устройство CH340 в выводе lsusb
device_to_find = "CH340"
dev_output = subprocess.check_output("lsusb")
list_dev = dev_output.split(b"\n")

for dev in list_dev:
    dev_str = dev.decode("utf-8")
    if device_to_find in dev_str:

        # print(dev_str)
        hwid = dev_str.split(" ")[5].upper()
        # print(hwid)

        # Получаем список всех доступных COM-портов
        ports = serial.tools.list_ports.comports()

        # Ищем COM-порт с заданным HWID
        for port in ports:
            if hwid in port.hwid:

                s = serial.Serial(port.device, 10000)
                s.write(b"\xfa")
                time.sleep(0.005)
                s.write(b"\x04")
                time.sleep(0.005)
                s.write(b"\x05")
                time.sleep(0.005)
                s.write(b"\x05")
                time.sleep(0.005)
                s.write(b"\x08")
                s.close()

                break
