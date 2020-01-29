#!/bin/bash

for file in ../helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

echo "Checking if Tmux is installed.."
if [[ ! "$(command -v tmux)" ]]; then
  echo "Intalling Tmux.."
  sudo apt update
  sudo apt install tmux urlview -y
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
  sudo apt install urlview # required for plugin
  ensure_symlink "$(pwd)/tmux.conf" "$HOME/.tmux.conf"

else
  echo "Tmux is already installed."
  exit 1; # exit
fi

echo "To install the plugins open tmux.conf and press prefix + I "
echo "Installing complete.
