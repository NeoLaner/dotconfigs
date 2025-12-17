export TERM="xterm-256color"
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE="$HOME/.config/zsh/history"
export EDITOR="nvim"

# Load the Zsh colors module
autoload -U colors && colors

# Set the prompt using the built-in color variables
export PS1="%{$fg[yellow]%}%1\~ $ %{$reset_color%}"

alias zshrc="$EDITOR $HOME/.zshrc"
alias reload="source $HOME/.zshrc"
alias editconfig="code $HOME/.config"

pr() { pnpm run "$@"; }
pi() { pnpm install "$@"; }
prc() { pnpm run check "$@"; }
prb() { pnpm run build "$@"; }


function prepend_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
	PATH="$1:$PATH"
  fi

}

prepend_path "$HOME/.local/bin"