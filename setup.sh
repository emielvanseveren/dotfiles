#!/bin/bash

NVM_VERSION=0.33.0

for file in ./tools/*; do
	[ -e "$file" ] || continue 
	echo "Loading tool '$file'.."
	source "$file"
done

#Get operating system
os=$(get_os)
echo "<OUTPUT>: The Operating system identified as: $os"

if [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
	if [ ! "$(command -v snap)" ]; then 
		if yesno "'snap' is required for $os to work, install now?" Y; then
      echo "$os: Installing snap.."
      sudo apt update
      sudo apt install -y snapd
      sudo apt install -y xsel
    else 
      echo "Exiting setup as snap is required.";
      exit 1;
    fi 
  else 
    echo "Snap is already installed."
  fi

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
  if yesno "The current shell is '$SHELL', change to zsh and install oh-my-zsh" Y; then 
    echo "Installing zsh.."
    sudo apt update
    sudo apt install zsh
    echo "changing default shell to zsh."
    sudo chsh -s "$(which zsh)"
    
    echo "installing oh-my-zsh"
    wget https://github.com/robbyrussel/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

    sudo apt install fonts-firacode
    ln -s "$(pwd)/zsh/themes/theunraveler.zsh-theme" "$HOME/.oh-my-zsh/themes/theunraveler.zsh-theme"
    
    # Make sure the symlink exists
    echo " setting ~/.zshrc link.."
    ensure_symlink "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
 fi
  else
    echo "The zsh shell is already in use."
 fi
fi

echo "creating symlinks.."

#nvm
echo "Checking if NVM is installed.."
if [[ !"$(command -v nvm)" ]] ; then
 if yesno "NVM is not installed. Install it?" Y; then
    echo "Installing NVM.."
    touch ~/.bash_profile
    curl -o- https://raw.githubuserocntent.com/creationix/nvm/v$"NVM_VERSION"/install.sh | bash
  fi
else
  echo "NVM is already installed."
fi

# vim
echo "checking if VIM is installed.."
if [[ ! "$(command -v vim)" ]]; then
  if yesno "VIM is not installed. install it?" Y; then
    echo "Installing vim.."
    sudo apt update 
    sudo apt install vim
  else
    echo "Vim is required to complete the setup. Exiting setup.."
    exit 1;
 fi
else
  echo "Vim is already installed."
fi

echo "Installing Vim Plug.."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall
vim -c "source ~/.vimrc"

echo "checking if Tmux is installed.."
if [[ ! "$(command -v tmux)" ]]; then
  if yesno "Tmux is not installed. install it?" Y; then
    echo "installing Tmux.."
    sudo apt update 
    sudo apt install tmux
    sudo apt install urlview

    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

  else 
    echo "Tmux is required to complete the setup. Exiting setup.."
    exit 1;
  fi
else
  echo "Tmux is already installed."
fi

echo "checking yarn is installed.."
if [[ ! "$(command -v yarn)" ]]; then
  if yesno "Yarn is not installed, install it?" Y; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list 
    sudo apt update && sudo apt install yarn 
  fi
fi

# restart computer
if yesno "Some installation require a restart to work, restart now?" Y; then
    echo "Restarting.."
    if [[ "$os" == "osx" ]]; then
      sudo shutdown -r now
    elif [[ "$os" == "ubuntu" || "$os" == "debian" ]]; then
      sudo shutdown -r -h +0
    fi
fi
