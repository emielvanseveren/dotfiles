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

echo 'Vim installation complete.'
