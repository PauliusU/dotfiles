# Common settings for ~/.zshrc or ~/.bashrc files

# -------------------------- ENV VARIABLES AND PATH  ---------------------------

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
    prepend_path() {
        # Prepend directory to PATH
        # Skipped if directory does not exist
        # Argument should be /absolute/path or ~/user/path
        if [ -d "$1" ]; then
            # Export to sub-processes (make it inherited by child processes)
            export PATH="$1:$PATH"
        fi
    }

    export BREW_HOME="$HOME/bin/homebrew"
    export CONDA_HOME="$HOME/bin/homebrew/anaconda3"
    export PYTHON_312_HOME="$HOME/Library/Python/3.12"
    export VOLTA_HOME="$HOME/.config/volta"

    # Order matters, first entry in PATH will take priority over later ones
    prepend_path "$CONDA_HOME/bin"      # Conda lowest in precedence for Python
    prepend_path "$HOME/.local/bin"     # Python packages store some bins here
    prepend_path "$BREW_HOME/bin"       # Use base Python instead of conda Python by default
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

# ----------------------------------- TMUX -------------------------------------
if [ -n "$ZSH_VERSION" ]; then # zsh
    bindkey -s ^f "tmux-sessionizer\n"
else
    echo "bash"
    # bind '"\C-f":" tmux-sessionizer\n"' # bash keybinding
fi
# Run TMUX if not in active session
if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    # "command -v" pathname  or  command  that  will be used by the shell
    # "-z" returns true if the string is empty, false if it contains something
    # "$TMUX" used to check if a tmux session is active
    tmux attach -t main || tmux new -s main
fi

# ------------------------- ZSH PLUGINS AND SETTNGS ----------------------------
if [ -n "$ZSH_VERSION" ]; then
    # Use default settings for the current shell
    # emulate -LR zsh

    # Change directory without `cd`
    setopt AUTO_CD
    # Use case-insensitive globbing (i.e. *.jpg = *.JPG)
    setopt NO_CASE_GLOB

    # History settings
    # Append to history file instead of replacing when using multiple zsh sessions.
    setopt APPENDHISTORY
    # Append commands as they are typed, not at shell exit
    setopt INC_APPEND_HISTORY
    # See commands entered using different terminals (share history between all zsh sessions)
    setopt SHARE_HISTORY
    # Expire duplicates first
    setopt HIST_EXPIRE_DUPS_FIRST
    # Do not store duplications
    setopt HIST_IGNORE_DUPS
    # Ignore duplicates when searching
    setopt HIST_FIND_NO_DUPS
    # Removes blank lines from history
    setopt HIST_REDUCE_BLANKS

    # Enable autocorrect
    setopt correct
    # Enable autocorrect for commands
    setopt correct_all

    # List the existing ZSH options
    # setopt

    # Bind Ctrl+A and Ctrl+E for jumping to start and end of line
    bindkey "^A" beginning-of-line
    bindkey "^E" end-of-line
    bindkey "^K" vi-kill-eol
    # Bind Ctrl+R for incremental patern history search
    bindkey "^R" history-incremental-pattern-search-backward
    # Bind UP and DOWN arrow keys for history search
    # Searches for the latest command in the history starting with typed text
    bindkey "^[[A" up-line-or-search
    bindkey "^[[B" down-line-or-search
    # Bind Ctrl+H to accept the current suggestion. left arrow key is default
    bindkey '^H' autosuggest-accept
    # Bind Shift + Tab
    bindkey '^[[Z' expand-or-complete
    # Get list of key bindings
    # bindkey

    # Load spaceship theme
    source $(brew --prefix)/opt/spaceship/spaceship.zsh

    # Load Antigen plugin manager
    source ~/.config/antigen.zsh
    # Use plugins from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle git
    antigen bundle npm
    # Use plugins from other sources
    antigen bundle z-shell/brew-completions

    # Tell Antigen that you're done.
    antigen apply
    # List currently loaded bundles
    antigen list

    function _zsh_fancy_ctrl_z {
        # Allow Ctrl-z to toggle between suspend and resume in ZSH
        # Useful to switch between Neovim and running terminal commands
        # Ref: https://stackoverflow.com/questions/35852061/avoid-adding-zsh-command-to-history
        fg
        zle push-input
        zle accept-line
    }
    #  Zsh Line Editor (ZLE)
    zle -N _zsh_fancy_ctrl_z
    bindkey "^Z" _zsh_fancy_ctrl_z
fi

# Load aliases (and other custom settings)
source "$DOTFILES/terminal/.aliases.sh"
source "$DOTFILES/terminal/.functions.sh"
source "$DOTFILES/terminal/.shellrc.private.sh"

get_os # Defined in .functions.sh
echo ".shellrc.sh for $OSFOUND loaded"
