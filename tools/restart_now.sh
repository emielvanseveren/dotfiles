#!/bin/bash

source ./yesno.sh

restart_now() {
  if yesno "Some installation require a restart to work, restart now?" Y; then
      if [[ "$1" == "osx" ]]; then
        sudo shutdown -r now
      elif [[ "$1" == "ubuntu" || "$1" == "debian" ]]; then
        sudo shutdown -r -h +0
      fi
  else
    echo "Do not forget to restart later"
  fi
}
