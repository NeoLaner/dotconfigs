# ==============================================================================
# ENVIRONMENT & LOCALE
# ==============================================================================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM="xterm-256color"
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE="$HOME/.config/zsh/history"
export EDITOR="nvim"

# ==============================================================================
# MODULES & OPTIONS
# ==============================================================================
# Load modules for colors and git info
autoload -U colors && colors
autoload -Uz vcs_info
setopt PROMPT_SUBST

# ==============================================================================
# ALIASES & FUNCTIONS
# ==============================================================================
alias zshrc="$EDITOR $HOME/.config/zsh/.zshrc"
alias reload="source $HOME/.config/zsh/.zshrc"
alias editconfig="code $HOME/.config/zsh/.config"

# PNPM shortcuts
alias pr="pnpm run"
alias pi="pnpm install"
alias prd="pnpm run dev"
alias prc="pnpm run check"
alias prb="pnpm run build"

docker_up() { sudo systemctl start docker; }
docker_down() { sudo systemctl stop docker; }

prepend_path() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# ==============================================================================
# PATH CONFIGURATION
# ==============================================================================
prepend_path "$HOME/.local/bin"

SCRIPT_DIR="/home/neo/dev/linux/dotconfigs/functional-scripts"
if [ -d "$SCRIPT_DIR" ]; then
    export PATH="$PATH:$(find "$SCRIPT_DIR" -type d | tr '\n' ':' | sed 's/:$//')"
fi

# ==============================================================================
# PROMPT CONFIGURATION (MINIMALIST DOTS)
# ==============================================================================
precmd() { vcs_info }

# Git Design
#  (Branch icon) |  (Small solid dot)
zstyle ':vcs_info:git:*' formats ' %F{242}on%f %F{cyan} %b%f%u%c'
zstyle ':vcs_info:git:*' actionformats ' %F{242}on%f %F{cyan} %b%f|%F{red}%a%f%u%c'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true

# Status Dots
zstyle ':vcs_info:git:*' unstagedstr ' %F{red}%f'  # Red dot for modified files
zstyle ':vcs_info:git:*' stagedstr ' %F{green}%f'    # Green dot for staged files

# --- THE PROMPT ---
#  (Folder) | ❯ (Chevron)
# Uses %B for Bold on the directory name
export PS1='%F{blue} %B%F{white}%1~%f%b${vcs_info_msg_0_} %F{yellow}❯%f '