# Dotfiles 🎉
This repository contains all the configuration files I use in my daily development environment (vim/zshrc/tmux/keyboard)

For new systems I added a script that will install the required software, plugins, symlinks.. 
A job will run on login to check if any of the dotfiles were updated.

## Keyboard ⌨
### update firmware 
**Windows**: install the [MSYS2](http://www.msys2.org/) builder.</br>
**Linux**: clone the qmk_firmware repository: `git clone https://github.com/qmk/qmk_firmware`.</br>
Execute the script `util/qmk_install.sh`. This can be found inside the **qmk_firmware** repository.
1. If you did not yet clone the qmk_firmware repository: `git clone https://github.com/qmk/qmk_firmware`.

2. Copy your wanted keyboard layout into this folder: `qmk_firmware/keyboards/[PCBNAME]/keymaps/[LAYOUTNAME]` </br>
e.g. `qmk_firmware/keyboards/dz60/keymaps/azerty`.

3. Update the layout to your own needs and requirements.

4. `make [PCBNAME]:[LAYOUTNAME]` e.g. `make dz60:emiel`. </br>
If there are no errors in your config files. It will create a .build folder in the repository root.


### Upload firmware
**Windows/MAC**: [QMK Toolbox GUI](https://github.com/qmk/qmk_toolbox/releases) </br>
**Linux**: [dfu-programmer CLI](https://github.com/dfu-programmer/dfu-programmer)


## .zshrc / ohmyzsh 🐚

## .vimrc 🔡

## .tmux 🧬

## EXAMPLE Remote mounted filesystem over ssh
`mkdir remoteDir`

`sshfs emiel@dev:/home/emiel ~/remoteDir`

