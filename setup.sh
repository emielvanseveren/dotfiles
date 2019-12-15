#!/bin/bash

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
		if ask echo "'snap' is required for $os to work, install now?" Y; then
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
  if [[ "$SHELL" != "/bin/zsh" ]]; then
    if yesno "The current shell is '$Shell', change to zsh?" Y; then 
      echo "Installing zsh.."
      sudo apt install update -y
      sudo apt install -y zsh
      chsh -s "$(which zsh)"

      # Create a smymlink to our zshrc.
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


# OSX support, I will add OSX support  whenever I buy a a macbook XD.

