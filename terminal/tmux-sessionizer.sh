#!/usr/bin/env bash

session_path=$(find \
    ~ \
    ~/.config \
    ~/Dropbox/code \
    ~/Dropbox/code/languages \
    ~/Dropbox/dev \
    ~/Dropbox/DropsyncFiles \
    ~/Dropbox/projects \
    ~/repos \
    -mindepth 1 -maxdepth 1 -type d | fzf
)

# Base folder name with underscores instead of dots
session_name=$(basename "$session_path" | tr . _)

echo "session_name: $session_name"
echo "session_path: $session_path"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -s "$session_name" -c "$session_path" -d
fi

tmux switch-client -t "$session_name"
