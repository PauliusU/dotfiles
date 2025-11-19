# Script for setting up environment variables and PATH
echo ".env.sh ◘"

# Default programs and settings
export EDITOR="nvim"
export VISUAL="code -w"
export LANG="en_US.UTF-8"
export TIME_STYLE='+%F %T' # ISO 8601 date format for ls and lsd

# Common paths
export DOTFILES="$HOME/Dropbox/code/dotfiles"
export SCRIPTS_PATH="$HOME/Dropbox/code/dotfiles/scripts"
if [ "$(uname)" = "Darwin" ]; then
    export CLOUD_STORAGE="$HOME/Library/CloudStorage"
fi

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# XDG non-standard convenience variables
export XDG_BIN_DIR=$HOME/.local/bin

# Home directory cleanup using XDG paths
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export ADOTDIR="$XDG_DATA_HOME/antigen"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export GOPATH="$XDG_DATA_HOME/go"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export PYTHONSTARTUP="$HOME/python/pythonrc"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export SONARLINT_USER_HOME="$XDG_DATA_HOME/sonarlint"
export TERMINFO="$XDG_DATA_HOME/terminfo"                          # ncurses terminfo database
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo" # ncurses terminfo database
export TS_NODE_HISTORY="$XDG_STATE_HOME/ts_node_repl_history"
export VOLTA_HOME="$XDG_DATA_HOME/volta"
export ZDOTDIR="$HOME/.config/zsh"
# source "$HOME/.cargo/env" # add Rust to system PATH

# Colorful man pages in 'less' pager
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# PATH
prepend_path() {
    # Prepend directory to PATH
    # Skipped if directory does not exist
    # Argument should be /absolute/path or ~/user/path
    if [ -d "$1" ]; then
        # Export to sub-processes (make it inherited by child processes)
        export PATH="$1:$PATH"
    fi
}

# Order matters, first entry in PATH will take priority over later ones
prepend_path "$HOME/.local/bin" # Python packages store some bins here
prepend_path "$VOLTA_HOME/bin" # Use Volta Node instead of global Node by default
prepend_path "$XDG_DATA_HOME/mise/shims"
prepend_path "$GOPATH/bin"

# Clean-up
unset -f prepend_path
