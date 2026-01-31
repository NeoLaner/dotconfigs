# ==============================================================================

# TTY DETECTION (Disable Nerd Font icons outside graphical session)

# ==============================================================================

if [[ -z "$WAYLAND_DISPLAY" && -z "$DISPLAY" ]]; then
autoload -U colors && colors
PS1='%F{green}%n@%m%f:%F{blue}%~%f %# '
return
fi
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
LD_LIBRARY_PATH=/usr/local/pgsql/lib
export LD_LIBRARY_PATH
export QT_QPA_PLATFORMTHEME=qt6ct
# ==============================================================================
# KEYBINDINGS (VI MODE - FIXED BACKSPACE)
# ==============================================================================
bindkey -v
export KEYTIMEOUT=1 

# 1. Fix Standard Backspace (Ensures it only deletes ONE character)
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# 2. Ctrl+Backspace (Deletes WHOLE word)
# Different terminals send different codes for Ctrl+Backspace. 
# \C-w is the unix standard for "word rubout"
bindkey '^[[3;5~' backward-kill-word # Common Linux code
bindkey '^W' backward-kill-word      # Traditional Unix code
bindkey '^H' backward-delete-char    # Re-enforcing standard backspace

# 3. Navigation & Undo
bindkey '^z' undo
bindkey '^[[1;5D' backward-word      # Ctrl+Left
bindkey '^[[1;5C' forward-word       # Ctrl+Right
bindkey '^[[3;5~' kill-word          # Ctrl+Delete (Forward)

# 4. Global Shortcuts (Emacs-style behavior in Insert mode)
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# ==============================================================================
# MODULES & OPTIONS
# ==============================================================================
autoload -U colors && colors
autoload -Uz vcs_info
setopt PROMPT_SUBST

# ==============================================================================
# ALIASES & FUNCTIONS
# ==============================================================================

# --- File/Config Editing ---
alias zshrc="$EDITOR $HOME/.config/zsh/.zshrc"
alias reload="source $HOME/.config/zsh/.zshrc"
alias editmyzshconfig="code $HOME/.config/zsh/.config" # Note: this opens a folder, not a file.

# --- pnpm Functions (for commands with arguments) ---
p() {
    pnpm "$@"
}
pr() {
    pnpm run "$@"
}
pi() {
    pnpm install "$@"
}

# --- pnpm Aliases (for commands WITHOUT arguments) ---
alias prd="pnpm run dev"
alias prc="pnpm run check"
alias prb="pnpm run build"
alias ptd="pnpm tauri dev"

# --- System/Service Controls ---
dockerup() { 
    sudo systemctl start docker 
}
dockerdown() { 
    sudo systemctl stop docker 
}

# --- PATH Helper Function ---
prepend_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

# ==============================================================================
# PATH CONFIGURATION
# ==============================================================================
# User-specific executable directories
prepend_path "$HOME/.local/bin"

# PostgreSQL binaries (manually compiled)
prepend_path "/usr/local/pgsql/bin"

# Include all subdirectories of a custom scripts directory to PATH
# This appends paths, giving them lower precedence than prepended paths.
SCRIPT_DIR="/home/neo/dev/linux/dotconfigs/functional-scripts"
if [ -d "$SCRIPT_DIR" ]; then
  # Use an array to handle spaces in directory names if necessary, though `find` output typically doesn't have issues.
  # For simplicity with tr/sed, we'll assume no spaces in dir names.
  # This appends all found directories.
  export PATH="$PATH:$(find "$SCRIPT_DIR" -type d | tr '\n' ':' | sed 's/:$//')"
fi

# ==============================================================================
# PROMPT CONFIGURATION (MINIMALIST DOTS)
# ==============================================================================
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' %F{242}on%f %F{cyan} %b%f%u%c'
zstyle ':vcs_info:git:*' actionformats ' %F{242}on%f %F{cyan} %b%f|%F{red}%a%f%u%c'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true

zstyle ':vcs_info:git:*' unstagedstr ' %F{red}%f' 
zstyle ':vcs_info:git:*' stagedstr ' %F{green}%f'

export PS1='%F{blue} %B%F{white}%1~%f%b${vcs_info_msg_0_} %F{yellow}❯%f '

# ==============================================================================
# EXECUTIONS
# ==============================================================================
eval "$(direnv hook zsh)"
