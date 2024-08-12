# Script for setting up environment variables and PATH
echo ".env.sh"

# Default programs and settings
export EDITOR="nvim"
export VISUAL="code -w"
export LANG="en_US.UTF-8"
# Common paths
export DOTFILES="$HOME/Dropbox/code/dotfiles"
export SCRIPTS_PATH="$HOME/Dropbox/code/dotfiles/scripts"
# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# Home directory cleanup
# go env -w GOPATH=$HOME/.cache/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export NVM_DIR="$XDG_DATA_HOME"/nvm
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# source "$HOME/.cargo/env" # add Rust to system PATH

if [ "$(uname)" = "Darwin" ]; then
    export CLOUD_STORAGE="$HOME/Library/CloudStorage"

    prepend_path() {
        # Prepend directory to PATH
        # Skipped if directory does not exist
        # Argument should be /absolute/path or ~/user/path
        if [ -d "$1" ]; then
            # Export to sub-processes (make it inherited by child processes)
            export PATH="$1:$PATH"
        fi
    }

    export CONDA_HOME="$HOME/bin/homebrew/anaconda3"
    export PYTHON_312_HOME="$HOME/Library/Python/3.12"
    export VOLTA_HOME="$HOME/.config/volta"

    # Order matters, first entry in PATH will take priority over later ones
    prepend_path "$CONDA_HOME/bin"      # Conda lowest in precedence for Python
    prepend_path "$HOME/.local/bin"     # Python packages store some bins here
    prepend_path "$PYTHON_312_HOME/bin" # User packages are installed here
    prepend_path "$VOLTA_HOME/bin"      # Use Volta Node instead of global Node by default

    # Clean-up
    unset -f prepend_path
fi

# Colorful man pages in 'less' pager
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
