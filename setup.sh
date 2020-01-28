#!/bin/bash

NVM_VERSION=0.33.0

for file in ./tools/*; do
	[ -e "$file" ] || continue 
	echo "Loading tool '$file'..."
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
    else 
      echo "<OUTPUT>: Exiting setup as 'snap' is required.";
      exit 1;
    fi 
  else 
    echo "'snap' is installed.."
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
  make -f ./makefile

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
    echo "<OUTPUT>: Installing vim.."
    sudo apt update 
    sudo apt install vim
  else
    echo "<OUTPUT>: Vim is required to complete the setup. Exiting setup.."
    exit 1;
 fi
else
  echo "<OUTPUT>: VIM is already installed."
fi


echo "<OUTPUT>: Installing Vim Plug.."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c PlugInstall
vim -c "source ~/.vimrc"



echo "checking if TMUX is installed.."
if [[ ! "$(command -v tmux)" ]]; then
  if yesno "TMUX is not installed. install it?" Y; then
    echo "installing TMUX.."
    sudo apt update 
    sudo apt install tmux
  else 
    echo "<OUTPUT>: Tmux is required to complete the setup. Exiting setup.."
    exit 1;
  fi
else
  echo "Tmux is already installed."
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

echo "setup complete!"
