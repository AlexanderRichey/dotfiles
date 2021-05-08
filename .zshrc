# Prompt
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

# Settings
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

# Mac
if [[ $(uname) == "Darwin" ]]; then
  # Brew
  eval $(/opt/homebrew/bin/brew shellenv)

  # Colors
  export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
  export CLICOLOR=1
fi

# Linux
if [[ $(uname) == "Linux" ]]; then
  # Brew
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  # Normalize pbcopy/paste
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'

  # Colors
  color_prompt=yes
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# Git completion
#
#     brew install zsh-completion
#
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  # https://github.com/zsh-users/zsh-completions/issues/433
  autoload -Uz compinit
  compinit
fi

# Add local bins
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Add global go bins
if [ -d "/usr/local/go/bin" ]; then
  PATH="/usr/local/go/bin:$PATH"
fi

# Add local go bins
if [ -d "$HOME/go/bin" ]; then
  PATH="$HOME/go/bin:$PATH"
fi

# Add local yarn bins
if [ -d "$HOME/.yarn/bin" ]; then
  PATH="$HOME/.yarn/bin:$PATH"
fi

# Work Stuff
if [[ $USER == "alrichey" ]]; then
  # It's okay
  if [ -d "$HOME/.toolbox/bin" ]; then
    PATH="$HOME/.toolbox/bin:$PATH"
  fi

  # AWS Autocomplete
  complete -C /usr/local/aws/bin/aws_completer aws

  # Ugh
  alias bb='brazil-build'

  # Annoying security
  export GOPROXY=direct
fi
