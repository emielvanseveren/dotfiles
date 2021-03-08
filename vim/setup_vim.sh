for file in '$(pwd)/../helper-functions/*'; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

sudo apt install vim -y
ensure_symlink '$(pwd)/vimrc' '$HOME/.vimrc'

vim -c 'source $HOME/.vimrc|q'

echo 'Vim installation complete.'
