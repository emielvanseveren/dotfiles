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
fi



# Ubuntu


# OSX support  should be added whenever I buy a a macbook xd.

