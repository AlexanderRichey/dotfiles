# Prompt
parse_git_branch() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

  if [[ ! "${BRANCH}" == "" ]]; then
    if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]; then
      STATUS="\e[0;31m✘"
    else
      STATUS="\e[0;32m✔"
    fi

    printf " \e[0;32m${BRANCH} ${STATUS}\e[m"
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


PS1="\n(\t) \$(current_venv)\[\e[1m\]\w\$(parse_git_branch) \[\033[0;31m\]\n ➜ \[\033[m\]"

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

# Brew
eval $(/opt/homebrew/bin/brew shellenv)

# Mac
if [[ $(uname) == "Darwin" ]]; then
  # Autocomplete
  if type brew &>/dev/null; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
        [[ -r "$COMPLETION" ]] && source "$COMPLETION"
      done
    fi
  fi

  # Case insensitive autocomplete
  bind "set completion-ignore-case on"
  bind "set show-all-if-ambiguous on"

  # Colors
  export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
  export CLICOLOR=1
fi

# Linux
if [[ $(uname) == "Linux" ]]; then
  # Autocomplete
  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi

  # Normalize pbcopy/paste
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'

  # Colors
  color_prompt=yes
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# Add .local/bin
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Add Go bins
if [ -d "/usr/local/go/bin" ]; then
  PATH="/usr/local/go/bin:$PATH"
fi

# Add local Go bins
if [ -d "$HOME/go/bin" ]; then
  PATH="$HOME/go/bin:$PATH"
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
