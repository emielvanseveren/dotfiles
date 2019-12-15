# Check if the user wants to setup vim.
if ! ask "$os: setup vim & vim spell?" Y; then
    return 0
fi

# I expect the following folder in my $HOME for temp stuff. Vim'll save the edit
# history and backups there.
mkdir ~/tmp

if [[ "$os" == "osx" ]]; then
    echo "$os: Installing vim..."
    brew install vim
elif [[ "$os" == "ubuntu" ]]; then
    echo "$os: Installing vim..."
    sudo apt update && sudo apt install vim
fi

# Install Vim Plug.
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Use our dotfiles for vimrc and vim spell.
ensure_symlink "$(pwd)/vim/vim-spell-en.utf-8.add" "$HOME/.vim-spell-en.utf-8.add"
ensure_symlink "$(pwd)/vim/vimrc" "$HOME/.vimrc"
