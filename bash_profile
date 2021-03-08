# general
alias claer="clear"
alias ls='ls --color=auto'
alias ll="ls -la"
alias untar='tar -zxvf'
alias vi='vim'
alias reloadzsh='source ~/.zshrc'

# Vim
alias vi='vim'

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# fix for broken sam-cli-path
export PATH="/home/linuxbrew/.linuxbrew/Cellar/aws-sam-cli/1.11.0/bin:$PATH"
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
