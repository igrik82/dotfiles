#!/usr/bin/env bash

ENABLED=""
DISABLED=""

#echo $ENABLED
snore() {
  local IFS
  [[ -n "${_snore_fd:-}" ]] || exec {_snore_fd}<> <(:)
  read -r ${1:+-t "$1"} -u "$_snore_fd" || :
}
DELAY=1

while snore $DELAY; do
  # Disable NetworkManager
  # if [[ $(nmcli -f GENERAL.STATE con show VPN | awk '{print $2}') == "activated" ]]; then

  if [[ $(ip -brief addr show wg0 | awk '{print $2}') == "UNKNOWN" ]]; then
    echo $ENABLED
  else
    echo $DISABLED
  fi
done

exit 0
