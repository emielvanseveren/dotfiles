#!/bin/bash

# Load helper functions (tools directory
for file in ./tools/*; do
	[ -e "$file" ] || continue 
	echo "Loading tool '$file'..."
	source "$file"
done

#Get operating system

os=$(get_os)
echo "os identified as: $os"

# Debian
if [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
	if [ ! -x "$(command -v snap)" ]; then # check if snap is installed
		if ask echo "$os: 'snap' is reqsuried for $os, install now?" Y; then



# Ubuntu


# OSX support  should be added whenever I buy a a macbook xd.

