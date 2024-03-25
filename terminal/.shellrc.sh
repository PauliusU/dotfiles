# Common settings for ~/.zshrc or ~/.bashrc files

# Load aliases (and other custom settings)
export DOTFILES="$HOME/Dropbox/code/dotfiles"
source "$DOTFILES/terminal/.env.sh"
source "$DOTFILES/terminal/.aliases.sh"
source "$DOTFILES/terminal/.functions.sh"
source "$DOTFILES/terminal/.shellrc.private.sh"

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

    eval "$(zoxide init zsh)" # enable zoxide for zsh
fi

get_os # Defined in .functions.sh
echo ".shellrc.sh for $OSFOUND loaded"
