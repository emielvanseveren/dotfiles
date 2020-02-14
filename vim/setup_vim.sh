# /bin/bash

for file in '$(pwd)/../helper-functions/*'; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

sudo apt install vim -y
ensure_symlink '$(pwd)/vimrc' '$HOME/.vimrc'

# Install vim plug repository
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall
vim -c 'source $HOME/.vimrc|q'

####################################################################################
###                                COC SETTINGS                                  ###
###                                                                              ###
###   MORE INFORMATION: github.com/neoclide/coc.nvim/wiki/Using-coc-extensions   ###
####################################################################################
echo 'Installing Conquer Of Completion extensions'
vim -c 'CocInstall -sync coc-json coc-css coc-html coc-tsserver coc-eslint coc-vimtex|q'
vim -c 'CocInstall coc-styled-components|q'
vim -c 'CocUpdateSync|q'
ensure-symlink '$(pwd)/coc-settings.json' '$HOME/.vim/coc-settings.json'

# TODO: create symlink package.json

echo 'Vim installation complete.'
