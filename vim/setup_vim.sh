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
  ensure_symlink '$(pwd)/vimrc' '$HOME/.vimrc'

  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall
  vim -c 'source $HOME/.vimrc|q'


  # TODO: coc symlink



else
  echo "Vim is already installed.."
  exit 1;
fi


# MORE INFORMATION: github.com/neoclide/coc.nvim/wiki/Using-coc-extensions 
echo 'Installing Coc extensions'
vim -c 'CocInstall -sync coc-json coc-css coc-html |q'
vim -c 'CocInstall coc-tsserver' # Typescript language features
vim -c 'CocInstall coc-eslint'
vim -c 'CocUpdateSync|q'

echo 'Installation complete.'
