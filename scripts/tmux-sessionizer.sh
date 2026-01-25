#!/usr/bin/env bash

# -L follows symlinks
session_path=$(find -L \
    ~ \
    ~/.config \
    $FS \
    ~/github \
    ~/dev \
    ~/projects \
    ~/repos \
    -mindepth 1 -maxdepth 1 -type d | fzf
)

if  ! command -v tmux; then
    echo "tmux is not installed. Switching path to $session_path"
    cd "$session_path" || exit 1
fi

# Base folder name with underscores instead of dots
session_name=$(basename "$session_path" | tr . _)

echo "session_name: $session_name"
echo "session_path: $session_path"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
    echo "tmux session does not exist, create it"
    tmux new-session -s "$session_name" -c "$session_path" -d
fi

tmux switch-client -t "$session_name"
