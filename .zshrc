export NVM_LAZY_LOAD=true # Enable Lazy load nvm
export NVM_COMPLETION=false  # Autocomplete nvm commands

# ZSH | oh-myzsh settings
ZSH_THEME="theunraveler"                                # ZSH theme - See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
CASE_SENSITIVE="false"                                  # Case sensitive completion
HYPHEN_INSENSITIVE="true"                               # while completing '_' and '-' will be interchangeable
COMPLETION_WAITING_DOTS="true"                          # Red dots whilst waiting for completion.
DISABLE_UNTRACKED_FILES_DIRTY="true"                    # disable marking untracked files (great for large repos)

# Start hyprland on default tty
TTY1=$(tty)
if [ "$TTY1" = "/dev/tty1" ]; then
    exec Hyprland
fi


###################
###   PLUGINS   ###
###################
source ~/.zplug/init.zsh                                # initialize plugins
zplug "lukechilds/zsh-nvm"                              # lazy loaded managed nvm because that thing is soooo slow it is insane

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load                                                # Should generate the plugins=(...) part. Add --verbose to see the output.

################################
###         EXPORTS          ###
################################
export OH_MY_ZSH_FOLDER="${HOME}/.oh-my-zsh"              # path to your oh-my-zsh installation
source $OH_MY_ZSH_FOLDER/oh-my-zsh.sh                     # IMPORTANT: should stay above the sets
export VISUAL=nvim                                        # Use nvim as default editor (Some programs rely on $VISUAL instead of $EDITOR)
export EDITOR="$VISUAL"                                   # Use nvim as default editor
export UPDATE_ZSH_DAYS=7                                  # auto-update every 7 days.
export DOCKER_BUILDKIT=1                                  # Enable rewrite docker build (faster but currently still behind feature flag)
export GPG_TTY=$(tty)                                     # Make gpg-key available
export MANPAGER="sh -c 'col -bx | bat -l man -p'"         # Set bat as default manpage pager
export GTEST_COLOR=1                                      # Enables colors while running gtests.
export NO_AT_BRIDGE=1                                     # Silence the stupid "AT bridge not available" dbus messages.
export PATH=$PATH:/usr/local/go/bin                       # go bin

unsetopt cdablevars
unsetopt complete_aliases                                 # Don't expand aliases _before_ completion has finished (src: https://stackoverflow.com/questions/14307086/tab-completion-for-aliased-sub-commands-in-zsh-alias-gco-git-checkout)
setopt PROMPT_SUBST                                       # The prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion.
setopt PATH_DIRS                                          # Perform path search even on command names with slashes
setopt AUTO_LIST                                          # Automatically list choices on ambiguous completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive matching

################################
###         ALIASES          ###
################################
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias reload='source ~/.zshrc'                          # reload zsh config with 'reload'
alias bwlogin='export BW_SESSION="$(bw unlock --raw)"'  # Bitwarden: automatically open vault when logging in. instead of 2 steps >:(
alias tf='terraform'                                    # Alias for terraform
alias grep='rg'                                         # Use ripgrep as default grep
alias sd="sudo shutdown now"
alias vim="nvim"
alias zshprof="time ZSH_DEBUGRC=1 zsh -i -c exit"
alias record='wf-recorder -p "preset=slower" -p="tune=film" -g "$(slurp)" -F fps=15 -c gif -f /tmp/"$(date +%s)".gif'  # Record gif
alias gitgone='git fetch --all --prune && git branch -avv | grep ": gone" | awk '{print $1}' | xargs git branch -D 2>/dev/null' # remove local branches when remote version of that branch existed and was explicitly removed.

# human readable sizes
alias du="du -h"
alias df="df -h"

alias k="kubectl"                                       # Alias for kubectl
alias kx="kubectx"                                      # Tool to swtich betwen contexts (clusters) on kubectl faster
alias kb="kubens"                                       # Tool to switch between kubernetes namespaces 

# tmux
alias tns="tmux new -s"
alias tm="~/.local/bin/tmux/tmux-sessionizer"           # create tmux session starting selected folder
alias ta="tmux at"
alias tas="tmux attach -t"
alias tk="pkill tmux"
alias td="tmux detach"
alias tls="tmux ls"

alias venv="source .venv/bin/activate"                  # Activate python virtual environment
alias pipr="python3 -m pip install -r requirements.txt" # Install python requirements from requirements.txt

# git
alias gd="git diff"
alias gds="git diff --staged"
alias gs="git status --short:m 'kjj:w'"
alias glg="git log --oneline --decorate --graph"

alias takaro="cd ~/code/takaro && tmux new -s takaro"   # Open tmux session in takaro folder
alias otiv3="cd ~/code/work/three && tmux new -s otiv3" # Open tmux session in otiv 3 repo
alias otiv1="cd ~/code/work/one && tmux new -s otiv1"   # Open tmux session in otiv 1 repo
alias lzd="lazydocker"                                  # Alias for lazydocker

################################
###    Add paths to $PATH    ###
################################
PATH=$PATH:~/.zsh_history_fix
PATH=$PATH:~/.cargo/bin
PATH=$PATH:~/.local/bin                                 # Mainly because pip installs binaries here
PATH="/home/emiel/.fly/bin:$PATH"
PATH="$PATH:/opt/nvim-linux64/bin"                      # Neovim install from binary is put in this location
WASMTIME_HOME="$HOME/.wasmtime"
PATH="$WASMTIME_HOME/bin:$PATH"
PICO_SDK_PATH=$HOME/code/pico/pico-sdk

##################################################
###    Add functions to special functions path ###
##################################################
FPATH=$FPATH:~/.config/zshfunctions

# functions need to be initialized before they can be run
autoload dcrb
autoload dcr
autoload dcrc
autoload dive
autoload jwtd
autoload randomstring
autoload source_helm
autoload source_kubectl
autoload wtr
autoload wlog
autoload reboot_win
autoload find_large_files
autoload ngrok

autoload -Uz compinit
compinit

# hook direnv into zsh
eval "$(direnv hook zsh)"

###############################
###       Completion stuff   ###
################################

# completion for google cloud.
if [ -f '/home/emiel/google-cloud-sdk/path.zsh.inc' ]; then . '/home/emiel/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/home/emiel/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/emiel/google-cloud-sdk/completion.zsh.inc'; fi

# completion for fzf

# arch
if [ -f '/usr/share/fzf/key-bindings.zsh' ]; then . '/usr/share/fzf/key-bindings.zsh'; fi
if [ -f '/usr/share/fzf/completion.zsh' ]; then . '/usr/share/fzf/completion.zsh'; fi
# ubuntu
if [ -f '/home/emiel/.fzf.zsh' ]; then .  '/home/emiel/.fzf.zsh'; fi

bindkey -v  # vi mode
bindkey '^R' fzf-history-widget

# add keybindings as in tmux
bindkey -s '^f' '~/.local/bin/tmux/tmux-sessionizer\n'
bindkey -s '^s' '~/.local/bin/tmux/tmux-switch-session\n'

