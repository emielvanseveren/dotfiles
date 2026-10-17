# ZSH | oh-myzsh settings
ZSH_THEME="theunraveler"                                # ZSH theme - See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
CASE_SENSITIVE="false"                                  # Case sensitive completion
HYPHEN_INSENSITIVE="true"                               # while completing '_' and '-' will be interchangeable
COMPLETION_WAITING_DOTS="true"                          # Red dots whilst waiting for completion.
DISABLE_UNTRACKED_FILES_DIRTY="true"                    # disable marking untracked files (great for large repos)
zstyle ':omz:update' mode auto                          # update oh-my-zsh without asking
zstyle ':omz:update' frequency 7                        # every 7 days (must be set before oh-my-zsh is sourced)

# Start hyprland on default tty
TTY1=$(tty)
if [ "$TTY1" = "/dev/tty1" ]; then
    exec Hyprland
fi


###################
###   PLUGINS   ###
###################
# oh-my-zsh plugins; loaded when oh-my-zsh is sourced below
zstyle ':omz:plugins:nvm' lazy yes                      # load nvm on first nvm/node/npm/npx/yarn/pnpm call, nvm.sh itself is slow
plugins=(nvm)

##################################################
###    Add functions to special functions path ###
##################################################
# Before oh-my-zsh, so compinit sees both dirs. Generated completions live in
# the second one: gitignored, rebuilt by regen_completions.
fpath=(~/.config/zshfunctions ~/.config/zsh/completions $fpath)
autoload -Uz ~/.config/zshfunctions/*(.:t)                # autoload every function file in there by name

################################
###         EXPORTS          ###
################################
export OH_MY_ZSH_FOLDER="${HOME}/.oh-my-zsh"              # path to your oh-my-zsh installation
source $OH_MY_ZSH_FOLDER/oh-my-zsh.sh                     # IMPORTANT: should stay above the sets
export VISUAL=nvim                                        # Use nvim as default editor (Some programs rely on $VISUAL instead of $EDITOR)
export EDITOR="$VISUAL"                                   # Use nvim as default editor
export GPG_TTY=$(tty)                                     # Make gpg-key available
export MANPAGER=less
export GTEST_COLOR=1                                      # Enables colors while running gtests.
export NO_AT_BRIDGE=1                                     # Silence the stupid "AT bridge not available" dbus messages.

export DELTA_FEATURES="+side-by-side"                     # Set default `(git-)delta` features

# Required for manual gstreamer build
export PKG_CONFIG_PATH=$HOME/usr/lib/x86_64-linux-gnu/pkgconfig/
export LD_LIBRARY_PATH=$HOME/usr/lib/x86_64-linux-gnu/
# Required for static manually compiled gstreamer plugins
export GST_PLUGIN_PATH="$HOME/code/work/gst-plugin-rs/target/release:$GST_PLUGIN_PATH"

unsetopt cdablevars
unsetopt complete_aliases                                 # Don't expand aliases _before_ completion has finished (src: https://stackoverflow.com/questions/14307086/tab-completion-for-aliased-sub-commands-in-zsh-alias-gco-git-checkout)
setopt PROMPT_SUBST                                       # The prompt string is first subjected to parameter expansion, command substitution and arithmetic expansion.
setopt PATH_DIRS                                          # Perform path search even on command names with slashes
setopt AUTO_LIST                                          # Automatically list choices on ambiguous completion.

# History. oh-my-zsh defaults to HISTSIZE 50000 but SAVEHIST 10000, so most
# of it never reached disk.
HISTSIZE=100000                                           # lines kept in memory
SAVEHIST=100000                                           # lines written to $HISTFILE
setopt HIST_IGNORE_ALL_DUPS                               # a repeated command replaces its older copies
setopt HIST_REDUCE_BLANKS                                 # strip extra blanks before saving
setopt HIST_FCNTL_LOCK                                    # fcntl locking on $HISTFILE; safer with SHARE_HISTORY across many tmux panes

################################
###         ALIASES          ###
################################
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias reloadzsh='source ~/.zshrc'                          # reload zsh config with 'reload'
alias reloadtmux="tmux source ~/.config/tmux/tmux.conf"    # Reload tmux (while inside tmux)
alias bwlogin='export BW_SESSION="$(bw unlock --raw)"'  # Bitwarden: automatically open vault when logging in. instead of 2 steps >:(
alias tf='tofu'                                         # Alias for open-source terraform (tofu)
alias sd="sudo shutdown now"
alias vim="nvim"
alias gstenv="python3 ~/code/work/gstreamer/gst-env.py"
alias zshprof="time ZSH_DEBUGRC=1 zsh -i -c exit"
alias record='wf-recorder -p "preset=slower" -p="tune=film" -g "$(slurp)" -F fps=15 -c gif -f /tmp/"$(date +%s)".gif'  # Record gif
alias gitgone="git fetch --all --prune && git branch -avv | grep ': gone' | awk '{print \$1}' | xargs git branch -D 2>/dev/null" # remove local branches when remote version of that branch existed and was explicitly removed.
alias gitwho='git config --show-origin --get user.email'
alias testgpg="echo \"test\" | gpg --clearsign"
alias killgpg="gpgconf --kill gpg-agent"
alias cdr='cd $(git rev-parse --show-toplevel)'
alias wscan="nmcli device wifi list --rescan yes"
alias python="python3"
alias gowork="cd /home/emiel/code/work"
alias gopers="cd /home/emiel/code/personal"

# Named directories (zsh built-in). A name registered with `hash -d` works as
# ~name anywhere a path is expected: `cd ~work`, `ls ~work/one/src`. Tab
# completion works after the slash, and the prompt shows ~work/one instead of
# /home/emiel/code/work/one.
hash -d work=~/code/work
hash -d pers=~/code/personal

# cdpath: directories `cd` searches when the target isn't under the current
# dir, so `cd locos` or `cd three` works from anywhere (with AUTO_CD, plain
# `locos` too). Tab completion includes them. A local dir of the same name wins.
cdpath=(~/code/work ~/code/personal)

# human readable sizes
alias du="du -h"
alias df="df -h"

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
alias gs="git status --short"
alias glg="git log --oneline --decorate --graph"

alias takaro="cd ~/code/takaro && tmux new -s takaro"   # Open tmux session in takaro folder
alias otiv3="cd ~/code/work/three && tmux new -s otiv3" # Open tmux session in otiv 3 repo
alias otiv1="cd ~/code/work/one && tmux new -s otiv1"   # Open tmux session in otiv 1 repo
alias lzd="lazydocker"                                  # Alias for lazydocker

################################
###    Add paths to $PATH    ###
################################
typeset -U path PATH                                    # keep PATH entries unique (also dedupes .zshenv/gcloud additions); needs both names, -U on path alone ignores PATH= assignments
# prepended: take precedence over system binaries (last line ends up first)
export PATH="$HOME/usr/bin:$PATH"                       # manually built tools
export PATH="$HOME/.local/bin:$PATH"                    # pip and other per-user installs
export PATH="$HOME/.opencode/bin:$PATH"                 # opencode
# appended
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:/usr/local/go/bin                     # go bin
export PATH=$PATH:/opt/meson                            # Custom build meson
export PATH=$PATH:/usr/lib/postgresql/16/bin
export PATH=$PATH:/opt/nvim-linux64/bin                 # Neovim install from binary is put in this location

eval "$(direnv hook zsh)"      # hook direnv into zsh
eval $(keychain --eval --quiet github github_personal)  # make sure ssh-agent is running on every terminal session

###############################
###       Completion stuff   ###
################################

# completion for google cloud.
if [ -f '/home/emiel/google-cloud-sdk/path.zsh.inc' ]; then . '/home/emiel/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/home/emiel/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/emiel/google-cloud-sdk/completion.zsh.inc'; fi

################################
###           fzf            ###
################################
source <(fzf --zsh)                                       # ^R history, ^T insert path, Alt+C cd, **<Tab> completion

# fd honours .gitignore/.ignore; --no-require-git applies them outside git checkouts too
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-require-git --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --no-require-git --exclude .git'

export FZF_DEFAULT_OPTS='--style=full:rounded --layout=reverse --tmux=center,80%,70%'   # framed sections; popup when inside tmux
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

bindkey -v  # vi mode
bindkey '^R' fzf-history-widget

# add keybindings as in tmux
bindkey -s '^f' '~/.local/bin/tmux/tmux-sessionizer\n'
bindkey -s '^s' '~/.local/bin/tmux/tmux-switch-session\n'

# Mark each prompt with OSC 133 so tmux copy mode can jump between prompts ([ and ])
_tmux_prompt_mark() { printf '\033]133;A\033\\'; }
autoload -Uz add-zsh-hook && add-zsh-hook precmd _tmux_prompt_mark
