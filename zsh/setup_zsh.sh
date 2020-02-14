
# load helper tools
for file in ../helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then

  sudo apt install zsh fonts-firacode -y
  sudo chsh -s "$(which zsh)"

  # oh my zsh
  wget https://github.com/robbyrussel/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
  # get custom plugin zsh-completions
  git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions

  echo "Ensure symlinks exist.."
  ensure_symlink "$(pwd)/themes/theunraveler.zsh-theme" "$HOME/.oh-my-zsh/themes/theunraveler.zsh-theme"
  ensure_symlink "$(pwd)/zshrc" "$HOME/.zshrc"

  else
    echo "The Z shell is already installed"
    exit 1;
fi

echo "Zsh installation complete."
