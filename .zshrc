bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char

export NVM_LAZY_LOAD=true    # Enable Lazy load nvm
export NVM_COMPLETION=true   # Autocomplete nvm commands

# ZSH | oh-myzsh settings
ZSH_THEME="theunraveler"                                # ZSH theme - See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
CASE_SENSITIVE="false"                                  # Case sensitive completion
HYPHEN_INSENSITIVE="true"                               # while completing '_' and '-' will be interchangeable
COMPLETION_WAITING_DOTS="true"                          # Red dots whilst waiting for completion.
DISABLE_UNTRACKED_FILES_DIRTY="true"                    # disable marking untracked files (great for large repos)

###################
###   PLUGINS   ###
###################
source ~/.zplug/init.zsh                                # initialize plugins
zplug "lukechilds/zsh-nvm"                              # lazy loaded managed nvmm because that thing is soooo slow it is insane

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load                                                # Should generate the plugins=(...) part. Add --verbose to see the output.

# plugin settings
unsetopt cdablevars
setopt PROMPT_SUBST                                       # The prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion.
setopt PATH_DIRS                                          # Perform path search even on command names with slashes
setopt AUTO_LIST                                          # Automatically list choices on ambiguous completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive matching


################################
###         EXPORTS          ###
################################
export OH_MY_ZSH_FOLDER="${HOME}/.oh-my-zsh"                        # path to your oh-my-zsh installation
export VISUAL=nvim                                                  # Use nvim as default editor (Some programs rely on $VISUAL instead of $EDITOR)
export EDITOR="$VISUAL"                                             # Use nvim as default editor
export UPDATE_ZSH_DAYS=7                                            # auto-update every 7 days.
export DOCKER_BUILDKIT=1                                            # Enable rewrite docker build (faster but currently still behind feature flag)
export GPG_TTY=$(tty)                                               # Make gpg-key available
export MANPAGER="sh -c 'col -bx | bat -l man -p'"                   # Set bat as default manpage pager
export GTEST_COLOR=1                                                # Enables colors while running gtests.
export NO_AT_BRIDGE=1                                               # Silence the stupid "AT bridge not available" dbus messages.
export MOZ_ENABLE_WAYLAND=1                                         # Enable wayland for firefox (reduces CPU usage)

################################
###         ALIASES          ###
################################
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias reload='source ~/.zshrc'                          # reload zsh config with 'reload'
alias bwlogin='export BW_SESSION="$(bw unlock --raw)"'  # Bitwarden: automatically open vault when logging in. instead of 2 steps >:(
alias tf='terraform'                                    # Alias for terraform
alias nvim='nvim'                                       # Show startup time when starting nvim
alias cat='bat'                                         # Use bat as default cat
alias grep='rg'                                         # Use ripgrep as default grep

################################
###    Add paths to $PATH    ###
################################
PATH=$PATH:~/.zsh_history_fix

################################
###       Other stuff        ###
################################

source <(kubectl completion zsh)
source <(helm completion zsh)
source <(npm completion)

# Key bindings
# ------------
source "/home/emiel/fzf/shell/key-bindings.zsh"


bindkey '^R' history-incremental-search-backward

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/emiel/google-cloud-sdk/path.zsh.inc' ]; then . '/home/emiel/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/emiel/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/emiel/google-cloud-sdk/completion.zsh.inc'; fi

source $OH_MY_ZSH_FOLDER/oh-my-zsh.sh # Reload config from oh-my-zsh


