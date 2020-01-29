# /bin/bash

for file in ../helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

echo "Checking if Vim is installed.."
if [[ ! "$(command -v vim)" ]]; then
  if [[ ! "$(command -v yarn)" ]]; then
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install yarn 
  else 
    echo "Yarn is already installed.."
  fi    

  sudo apt update
  sudo apt install vim -y
  ensure_symlink "$(pwd)/vimrc" "$HOME/.vimrc"

  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall
  vim -c "source $HOME/.vimrc"


  # TODO: coc symlink

else
  echo "Vim is already installed.."
  exit 1;
fi

echo "Installation complete."
