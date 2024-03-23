#!/bin/bash

function create_terminal_commands() {
    # Makes all scripts in provided folder available as global commands in terminal
    # Param: $1 - path to scripts folder

    if [ -z "$1" ]; then
        echo "ERROR: scripts path"
        return 1
    fi

    # Ensure target directory exists (it's missing in macOS fresh install)
    mkdir -p "$HOME/.local/bin"

    for script in $1; do
        # Use name without extension as command name
        BASE_NAME="$(basename "${script%.*}")"
        echo "script: $script"
        echo "BASE_NAME: $BASE_NAME"
        echo "$script"
        # Create symlink for looped script
        ln -sf "$script" "$HOME/.local/bin/$BASE_NAME"
    done
    echo "Terminal commands created for $1"
}

create_terminal_commands "$DOTFILES/scripts/*.sh"
create_terminal_commands "$DOTFILES/scripts/private/*.sh"
