# Common settings for ~/.zshrc or ~/.bashrc files

# ---------------------------------- OS CHECK  ---------------------------------
export IS_LINUX=false
export IS_MAC=false
export IS_WINDOWS=false
export IS_WSL=false

# Determine OS by OS name (-s) and OS release (-r) like "Darwin 21.6.0"
case "$(uname -sr)" in #
Darwin*)
    OSFOUND="macOS"
    IS_MAC=true
    ;;
Linux*microsoft*)
    OSFOUND="WSL" # Windows Subsystem for Linux
    IS_WSL=true
    ;;
Linux*)
    OSFOUND="Linux"
    IS_LINUX=true
    ;;
MINGW* | CYGWIN* | MSYS*) # E.g. Git Bash for Windows
    OSFOUND="Windows"
    IS_WINDOWS=true
    ;;
*)
    OSFOUND="Other OS"
    ;;
esac

# -------------------------- ENV VARIABLES AND PATH  ---------------------------

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
# Default settings
export EDITOR="nvim"
export VISUAL="code -w"
export LANG="en_US.UTF-8"
# Common paths
export DOTFILES="$HOME/Dropbox/code/dotfiles"
export SCRIPTS_PATH="$HOME/Dropbox/code/dotfiles/scripts"

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
export VOLTA_HOME="$HOME/.volta"
# Order matters, first entry in PATH will take priority over later ones
prepend_path "$CONDA_HOME/bin"      # Conda lowest in precedence for Python
prepend_path "$HOME/.local/bin"     # Python packages store some bins here
prepend_path "$BREW_HOME/bin"       # Use base Python instead of conda Python by default
prepend_path "$PYTHON_312_HOME/bin" # User packages are installed here
prepend_path "$VOLTA_HOME/bin"      # Use Volta Node instead of global Node by default

# Clean-up
unset -f prepend_path

source "$HOME/.cargo/env" # add Rust to system PATH

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
    # Change directory without `cd`
    setopt auto_cd

    # Bind Ctrl + R for incremental patern history search
    bindkey "^R" history-incremental-pattern-search-backward
    # bindkey '^R' history-incremental-search-backward # non-patern search

    # Load spaceship theme
    source $(brew --prefix)/opt/spaceship/spaceship.zsh

    # Load Antigen plugin manager
    source ~/.config/antigen.zsh
    # Use plugins from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle git
    antigen bundle npm
    # Use plugins from other sources
    antigen bundle z-shell/brew-completions
    # Bind Ctrl + K to accept the current suggestion. left arrow key is default
    bindkey '^k' autosuggest-accept

    # # Bind UP and DOWN arrow keys
    bindkey "^[[A" history-search-backward
    bindkey "^[[B" history-search-forward

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

echo ".shellrc.sh for $OSFOUND loaded"
