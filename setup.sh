#! /bin/bash

# TODO: setup nvm
NVM_VERSION="NOT SET YET"
VIM_SCRIPT_PATH="./vim/setup_vim.sh"
TMUX_SCRIPT_PATH="./tmux/setup_tmux.sh"
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
sudo apt update && sudo apt install zathura latexmk git curl node npm -y

# Install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt install yarn -y
echo "yarn version: $(yarn --version)"

# create symlinks
make -f ./makefile

# vim | tmux | zsh
bash VIM_SCRIPT_PATH
bash TMUX_SCRIPT_PATH
bash ZSH_SCRIPT_PATH

# Restart computer
if yesno "Some installations require a restart to work, restart now?" Y; then
  echo "Restarting.."
  sudo shutdown -r -h +0
fi
