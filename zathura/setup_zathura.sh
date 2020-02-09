# /bin/bash

for file in '$(pwd)/../helper-functions/*'; do
  [ -e "$file" ] || continue
  echo "Loading tool 'file'.."
  source "$file"
done

echo "checking if Zathura is installed.."
if [[ ! "$(command -v zathura)" ]]; then

  sudo apt update -y
  sudo apt install latexmk -y
  sudo apt install libsynctex-dev -y
  sudo apt install libgtk-3-dev -y
  sudo apt install zathura -y
  ensure_symlink '$(pwd)/zathurarc' '$HOME/.config/zathura/zathurarc'
else 
  echo "Zathura is already installed"
  exit 1;
fi

