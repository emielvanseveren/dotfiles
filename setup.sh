#! /bin/bash

VIM_SCRIPT_PATH="./vim/setup_vim.sh"
ZSH_SCRIPT_PATH="./zsh/setup_zsh.sh"

# import helper functions
for file in ./helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool 'file'.."
  source "$file"
done

# get os
os=$(get_os)
echo "The operating system is identified as: $os"

# Make sure general packages are installed
sudo apt-get update && sudo apt-get install git curl wget node npm -y

# create symlinks
make -f ./makefile

# vim | tmux | zsh
bash $VIM_SCRIPT_PATH
bash $TMUX_SCRIPT_PATH
bash $ZSH_SCRIPT_PATH

# Restart computer
if yesno "Some installations require a restart to work, restart now?" Y; then
  echo "Restarting.."
  sudo shutdown -r -h +0
fi
