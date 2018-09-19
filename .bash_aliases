alias co='cd ~/Code'
alias dt='cd ~/Desktop'
alias vim='nvim'
alias vi='nvim'

if [[ $(uname) == "Linux" ]]; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
