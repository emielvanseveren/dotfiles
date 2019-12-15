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

