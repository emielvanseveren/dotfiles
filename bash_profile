# general
alias claer="clear"
alias ls='ls --color=auto'
alias ll="ls -la"
alias untar='tar -zxvf'
alias wget='wget -c'
alias daddy='sudo '
alias pls='apt '
alias vi='vim'
alias fuck='sudo !!'
alias reloadzsh='source ~/.zshrc'
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias screen='gnome-screenshot -i'

# docker
alias dcu='sudo docker-compose up -d'
alias dcd='sudo docker-compose down'
alias dcdu='sudo docker-compose down && sudo docker-compose up -d'
alias dps='docker ps'

# Git alias
alias gadd='git add -A'
alias gb='git branch'
alias gbranch='git branch'
alias gcommit='git commit'
alias gcheck='git checkout'
alias gdiff='gitt diff --color'
alias gfetch='git fetch origin master'
alias master='git checkout master'
alias gpull='git pull origin master'
alias gpush='git push origin master'

# Vim
alias vi='vim'
alias vimtex='vim --servername vim'

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# fix for broken sam-cli-path
export PATH="/home/linuxbrew/.linuxbrew/Cellar/aws-sam-cli/1.11.0/bin:$PATH"


# run startx on login tty1
# TODO: this should only be fired if the operating sytem is Arch.
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# Alias for power options
alias suspend='sudo systemctl suspend' # suspend-to-RAM (instant, but uses more power than hibernation
alias poweroff='sudo systemctl poweroff'
alias lock='i3-lock-fancy'


export VISUAL=vim
export EDITOR="$VISUAL"


SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
        #ps ${SSH_AGENT_PID} doesn't work under cywgin
            ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
                    start_agent;
                        }
                        else
                            start_agent;
fi
