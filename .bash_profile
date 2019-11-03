###
# Functions
###

function parse_git_branch {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`

    if [ ! "${BRANCH}" == "" ]; then
        if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]
        then
          STATUS="\e[0;31m✘"
        else
          STATUS="\e[0;32m✔"
        fi

        printf " ${BRANCH} ${STATUS}"
    else
        echo ""
    fi
}

function current_venv {
  if [[ ! -z "$VIRTUAL_ENV" ]]; then
    # Show this info only if virtualenv is activated:
    local dir=$(basename "$VIRTUAL_ENV")
    echo "($dir) "
  fi
}


###
# Promp Definition & Configuration
###

PS1="\n(\t) \$(current_venv)\[\e[1m\]\w\[\e[0m\]\[\e[0;32m\]\$(parse_git_branch)\[\e[m\] \[\033[0;31m\]\n ➜ \[\033[m\]"

# Disable the standard venv prompt:
export VIRTUAL_ENV_DISABLE_PROMPT=1


###
# Ignore Case
###

if [[ $(uname) == "Darwin" ]]; then
  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"
fi


###
# Autocomplete
###

# Standard
if [[ $(uname) == "Linux" ]]; then
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi
fi

if [[ $(uname) == "Darwin" ]]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# Git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


###
# NVM Setup
###

export NVM_DIR="$HOME/.nvm"

if [[ $(uname) == "Linux" ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

if [[ $(uname) == "Darwin" ]]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

###
# GCloud Setup
###

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/alrichey/Code/google-cloud-sdk/path.bash.inc' ]; then
  . '/Users/alrichey/Code/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/alrichey/Code/google-cloud-sdk/completion.bash.inc' ]; then
  . '/Users/alrichey/Code/google-cloud-sdk/completion.bash.inc'
fi


###
# Mac Configurations
###

if [[ $(uname) == "Darwin" ]]; then
  export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
  export CLICOLOR=1

  alias vi=/usr/local/bin/vim
  alias vim=/usr/local/bin/vim

  eval "$(rbenv init -)"
fi


###
# Linux Configurations
##

if [[ $(uname) == "Linux" ]]; then
	color_prompt=yes
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi


###
# Editor Setting
###

export EDITOR=vi
export VISUAL=vi


###
# Shortcuts
###

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias co='cd ~/Code'
alias dt='cd ~/Desktop'
alias vi='nvim'
alias vim='nvim'


###
# Exports
###

if [ -f ~/.exports ]; then
  . ~/.exports
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes go binaries if they exist
if [ -f /usr/local/go/bin ]; then
  export PATH=$PATH:/usr/local/go/bin
fi


###
# Work Stuff
###

if [[ $USER == "alrichey" ]]; then
  complete -C /usr/local/aws/bin/aws_completer aws
fi
