#!/usr/bin/env bash

# if [[ $(nmcli -f GENERAL.STATE con show VPN | awk '{print $2}') == "activated" ]]; then
#   nmcli connection down VPN
# else
#   nmcli connection up VPN
# fi

if [[ $(ip -brief addr show wg0 | awk '{print $2}') == "UNKNOWN" ]]; then
  sudo systemctl stop wg-quick@wg0
else
  sudo systemctl start wg-quick@wg0
fi
