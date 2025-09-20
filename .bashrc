PATH=$PATH:~/bin:~/.cargo/bin

eval $(keychain --eval --quiet)

export HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd:vim:nvim'

alias cdr='cd "$(git rev-parse --show-toplevel)"'

eval "$(starship init bash)"
eval "$(direnv hook bash)"
