# check if the symlink already exists if not. Create it
ensure_symlink() {
  #paths
  target ="$1"
  symlink="$2"

  echo "Linking '$symlink' to '$path'"
  if [[ ! -e "symlink' ]]; then
    ln -sf "$target" "$symlink"
  elif [[ ! "$(readlink $symlink)" = "$target" ]]; then
    rm -rf "$symlink"
    ln -sf "$target"
  fi
}

