# /bin/bash

for file in ../helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

echo "Checking if Vim is installed.."
if [[ ! "$(command -v vim)" ]]; then
  sudo apt update
  sudo apt install vim -y
  ensure_symlink "$(pwd)/vimrc" "$HOME/.vimrc"

  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall
  vim -c "source $HOME/.vimrc"

else
  echo "Vim is already installed.."
  exit 1;
fi

echo "Installation complete."
