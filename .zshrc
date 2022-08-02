# Configuration for ZSH
# Author: AlexanderRichey (alrichey@)

# Prompt
# -----------------------------------------------------------------------------
parse_git_branch() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  if [[ ! "${BRANCH}" == "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]; then
      STATUS="\e[0;31m✘"
    else
      STATUS="\e[0;32m✔"
    fi

    printf " \e[0;32m${BRANCH} ${STATUS}"
  else
    printf ""
  fi
}

current_venv() {
  if [[ ! -z "$VIRTUAL_ENV" ]]; then
    # Show this info only if virtualenv is activated:
    local dir=$(basename "$VIRTUAL_ENV")
    echo "($dir) "
  fi
}

setopt PROMPT_SUBST
PROMPT='
(%*) %n@%m $(current_venv)%B%~%b$(parse_git_branch)
 %F{red}➜%f '


# Global Settings & Shortcuts
# -----------------------------------------------------------------------------
export VIRTUAL_ENV_DISABLE_PROMPT=1
export EDITOR=vi
export VISUAL=vi

# Vi mode in bash
set -o vi

# Shortcuts
alias co='cd ~/Code'
alias dt='cd ~/Desktop'
alias vim='nvim'
alias del='gio trash'


# Mac Settings
# -----------------------------------------------------------------------------
if [[ $(uname) == "Darwin" ]]; then
  # Brew
  if [ -z $TMUX ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
  fi

  # Colors
  export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
  export CLICOLOR=1
fi


# Linux Settings
# -----------------------------------------------------------------------------
if [[ $(uname) == "Linux" ]]; then
  # Brew
  if [ -z $TMUX ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  fi

  # Normalize pbcopy/paste
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'

  # Colors
  color_prompt=yes
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi


# Git Completion
# -----------------------------------------------------------------------------
#
#     brew install zsh-completion
#
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  # https://github.com/zsh-users/zsh-completions/issues/433
  autoload -Uz compinit
  compinit
fi


# Add Bins
# -----------------------------------------------------------------------------
BIN_PATHS=(
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "/usr/local/go/bin"
  "$HOME/.yarn/bin"
  "$HOME/.toolbox/bin"
)

for p in "${BIN_PATHS[@]}"; do
  if [ -d $p ] && [ -z $TMUX ] ; then
    PATH="$p:$PATH"
  fi
done


# Work Stuff
# -----------------------------------------------------------------------------
if [[ $USER == "alrichey" ]]; then
  # Mechanic
  [ -f "$HOME/.local/share/mechanic/complete.zsh" ] && source "$HOME/.local/share/mechanic/complete.zsh"

  # AWS Autocomplete
  complete -C /usr/local/aws/bin/aws_completer aws

  # Ugh
  alias bb='brazil-build'
  alias bre='brazil-runtime-exec'
  alias brc='brazil-recursive-cmd'
  alias bbb='brc --allPackages brazil-build'

  # Annoying security
  export GOPROXY=direct
fi

# Helpers
# -----------------------------------------------------------------------------
timber () {
    sshenv -a -e TimberFS/$1/Parkside
}

rn () {
  tmux rename-window $1
}
