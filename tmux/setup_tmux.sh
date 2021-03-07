#!/bin/bash

for file in ../helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

# URLVIEW: Required dependency to automatically redirect urls in tmux to a browserview.
sudo apt install tmux urlview -y

# Get tmux package manager (TPM) repository
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
ensure_symlink "$(pwd)/tmux.conf" "$HOME/.tmux.conf"

echo "IMPORTANT: To install the plugins open tmux.conf and press prefix + I "
echo "Tmux installation complete.
