PATH=$PATH:~/bin:~/.cargo/bin

eval $(keychain --eval --quiet)

export HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd:vim:nvim'

alias cdr='cd "$(git rev-parse --show-toplevel)"'
alias cdc='cd ~/.config/'
alias bload='source ~/.bashrc'
alias pip-uninstall-all="pip list | awk '! /---*/ && $1 != \"Package\" && != \"pip\" {print $1}' | xargs pip uninstall -y"

eval "$(starship init bash)"
eval "$(direnv hook bash)"
