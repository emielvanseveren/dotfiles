# Dotfiles 🎉
This repository contains all the configuration files I use in my daily development environment (vim/zshrc/tmux/keyboard)

For new systems I added a script that will install the required software, plugins, symlinks.. 
A job will run on login to check if any of the dotfiles were updated.

## Keyboard ⌨
### update firmware 
##### Setup
**Windows**: install the [MSYS2](http://www.msys2.org/) builder.</br>
**Linux**: clone the qmk_firmware repository: `git clone https://github.com/qmk/qmk_firmware`.</br>
Execute the script `util/qmk_install.sh`. This can be found inside the **qmk_firmware** repository.
1. If you did not yet clone the qmk_firmware repository: `git clone https://github.com/qmk/qmk_firmware`.

2. Copy your wanted keyboard layout into this folder: `qmk_firmware/keyboards/[PCBNAME]/keymaps/[LAYOUTNAME]` \
e.g. `qmk_firmware/keyboards/dz60/keymaps/azerty`.

3. Update the layout to your own needs.

4. `make [PCBNAME]:[LAYOUTNAME]` e.g. `make dz60:emiel`.\ 
If there are no errors in your config files. It will create a .build folder in the repository root.



### Upload firmware



## .zshrc / ohmyzsh 🐚

## .vimrc 🔡

## .tmux 🧬
