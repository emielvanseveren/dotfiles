#!/bin/bash

restart_now() {
  read -r -p "${USER^}, Some changes require a restart - restart now [Y/n] " input

  case $input in 
    [yY][eE][sS]|[yY])
      if [[ "$1" == "osx" ]]; then
        sudo shutdown -r now
      elif [[ "$1" == "ubuntu" || "$1" == "debian" ]]; then
        sudo shutdown -r -h +0
      fi
    ;;
    [nN][oO]|[nN])
      echo "No"
      ;;
    *)
    echo "Invalid input.."
    exit 1
  ;;
  esac
}

restart_now ubuntu

