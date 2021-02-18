# BAD, NOT GOOD
#
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
(%*) $(current_venv)%B%~%b$(parse_git_branch)
 %F{red}➜%f '

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

# Case insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
