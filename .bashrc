cat ~/.cache/wal/sequences

PATH=$PATH:~/bin:~/.cargo/bin

shopt -s autocd cdspell

eval $(keychain --eval --quiet)

export HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd:vim:nvim'

export ZK_NOTEBOOK_DIR=~/.notes

alias cdr='cd "$(git rev-parse --show-toplevel)"'
alias cdc='cd ~/.config/'
alias bload='source ~/.bashrc'
,() {
	nix-shell -p "$1" --run "$*"
	}
alias pip-uninstall-all="pip list | awk '! /---*/ && $1 != \"Package\" && != \"pip\" {print $1}' | xargs pip uninstall -y"

# kitty specific aliases
alias icat="kitten icat"

eval "$(starship init bash)"
eval "$(direnv hook bash)"
