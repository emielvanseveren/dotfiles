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
		if yesno echo "'snap' is required for $os to work, install now?" Y; then
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
      sudo apt install update -y
      sudo apt install -y zsh
      chsh -s "$(which zsh)"

      # Make sure the symlink exists
      echo " setting ~/.zshrc link.."
      ensure_symlink "$(pwd)/zsh/zshrc" "$HOME/.zshrc"
    fi
  else
    echo "The zsh shell is already in use"
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
else
  echo "Do not forget to restart later"
fi

# Check if nvm is installed
nvm_installed=$(command -v nvm)
echo "Checking if NVM is installed.."
if [[ ${nvm_installed} != 0 ]] ; then
  if yesno "NVM is not installed. Install it?" Y; then
    echo "Installing NVM.."
    touch ~/.bash_profile
    curl -o- https://raw.githubuserocntent.com/creationix/nvm/v$"NVM_VERSION"/install.sh | bash
  fi
else
  echo "NVM is already installed."
fi


# OSX support, I will add OSX support  whenever I buy a a macbook XD.

