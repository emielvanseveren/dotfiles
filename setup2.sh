#! /bin/bash

for file in ./helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool 'file'.."
  source "$file"
done



os=$(get_os)
echo "The operating system is identified as: $os"

echo "checking if Yarn is installed.."
if [[ ! "$(command -v yarn)" ]]; then
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update
  sudo apt install yarn -y
fi

echo "installing latexmk mupdf pdfviewer"
if [[ ! "$(command -v yarn)" ]]; then
  sudo apt update
  sudo apt install mupdf zathura -y 
  sudo apt install latexmk -y
fi

# Restart computer
if yesno "Some installations require a restart to work, restart now?" Y; then
  echo "Restarting.."
  sudo shutdown -r -h +0
fi
