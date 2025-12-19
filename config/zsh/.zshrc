export TERM="xterm-256color"
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE="$HOME/.config/zsh/history"
export EDITOR="nvim"

# Load the Zsh colors module
autoload -U colors && colors

# Set the prompt using the built-in color variables
export PS1="%{$fg[yellow]%}%1\~ $ %{$reset_color%}"

alias zshrc="$EDITOR $HOME/.config/zsh/.zshrc"
alias reload="source $HOME/.config/zsh/.zshrc"
alias editconfig="code $HOME/.config/zsh/.config"

pr() { pnpm run "$@"; }
pi() { pnpm install "$@"; }
prd() { pnpm run dev "$@"; }
prc() { pnpm run check "$@"; }
prb() { pnpm run build "$@"; }

# systemctls
docker:up() { systemctl start docker; }


function prepend_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
	PATH="$1:$PATH"
  fi

}

prepend_path "$HOME/.local/bin"
# Add the main folder and all subfolders to PATH
if [ -d "/home/neo/dev/linux/dotconfigs/functional-scripts" ]; then
    export PATH="$PATH:$(find /home/neo/dev/linux/dotconfigs/functional-scripts -type d | tr '\n' ':' | sed 's/:$//')"
fi