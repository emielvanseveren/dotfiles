
# load helper tools
for file in ../helper-functions/*; do
  [ -e "$file" ] || continue
  echo "Loading tool '$file'.."
  source "$file"
done

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
  
  sudo apt update
  sudo apt install zsh -y
  sudo chsh -s "$(which zsh)"

  wget https://github.com/robbyrussel/oh-my-zsh/raw/master/tools/install.sh -O - | zsh                    # oh-my-zsh
  git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions  # custom plugin

  sudo apt install fonts-firacode -y                                                                      # firacode font (unicode support)
  ensure_symlink "$(pwd)/themes/theunraveler.zsh-theme" "$HOME/.oh-my-zsh/themes/theunraveler.zsh-theme"

  echo "Ensure zshrc symlink exists.."
  ensure_symlink "$(pwd)/zshrc" "$HOME/.zshrc"

  else
    echo "The Z shell is already installed"
fi
