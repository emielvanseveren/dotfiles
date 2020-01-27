#!/bin/bash

NVM_VERSION = 0.33.0


# Load helper functions (tools directory
for file in ./tools/*; do
	[ -e "$file" ] || continue 
	echo "Loading tool '$file'..."
	source "$file"
done

#Get operating system
os=$(get_os)
echo "The Operating system identified as: $os"

########################
#   Debian / Ubuntu
########################

if [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
  # check if snap is installed
	if [ ! -x "$(command -v snap)" ]; then 
		if yesno "'snap' is required for $os to work, install now?" Y; then
      echo "$os: Installing snap.."
      sudo apt install -y snapd
    else 
      echo "Exiting setup as 'snap' is required.";
      exit 1;
    fi 
  else 
    echo "'snap' is installed.."
  fi

  # check if zsh is installed
  echo "checking shell.."
  if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    if yesno "The current shell is '$SHELL', change to zsh?" Y; then 
      echo "Installing zsh.."
      sudo apt update
      sudo apt install zsh
      chsh -s "$(which zsh)"

      # Make sure the symlink exists
      echo " setting ~/.zshrc link.."
      ensure_symlink "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
    fi
  else
    echo "The zsh shell is already in use."
  fi
fi

# create symlinks
if yesno "create symlinks (vim, tmux, zsh)" Y; then
    echo "creating symlinks.."
    make -f ./makefile
else 
  echo "No symbolic links created."
fi

###########
#  NVM
##########
echo "Checking if NVM is installed.."
nvm_installed=$(command -v nvm)
if [[ ${nvm_installed} != 0 ]] ; then
  if yesno "NVM is not installed. Install it?" Y; then
    echo "Installing NVM.."
    touch ~/.bash_profile
    curl -o- https://raw.githubuserocntent.com/creationix/nvm/v$"NVM_VERSION"/install.sh | bash
  fi
else
  echo "NVM is already installed."
fi

##########
#  VIM
##########
echo "checking if VIM is installed.."
vim_installed=$(command -v vim)
if [[ ${vim_installed} != 0 ]]; then
  if yesno "VIM is not installed. install it?" Y; then
    echo "installing vim.."
    sudo apt update 
    sudo apt install vim
  fi
else
  echo "vim is already installed."
fi

# install VIMPlug 
echo "Checking if VIMPLUG is installed.."

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c PlugInstall
vim -c source ~/.vimrc 


##########
#  TMUX
##########
echo "checking if TMUX is installed.."
tmux_installed= $(command -v tmux)
if [[ ${tmux_installed} != 0 ]]; then
  if yesno "TMUX is not installed. install it?" Y; then
    echo "installing TMUX.."
    sudo apt update 
    sudo apt install tmux
  fi
else
  echo "tmux is already installed."
fi


########################
#
#  If everything is complete, restart the computer. 
# 
#######################
if yesno "Some installation require a restart to work, restart now?" Y; then
    echo "Restarting.."
    if [[ "$os" == "osx" ]]; then
      sudo shutdown -r now
    elif [[ "$os" == "ubuntu" || "$os" == "debian" ]]; then
      sudo shutdown -r -h +0
    fi
else
  echo "Do not forget to restart later. Some things may not work."
fi


# I will add OSX support, whenever I buy a Macbook Pro XD.

