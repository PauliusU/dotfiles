#!/usr/bin/env bash

session=$(find ~ ~/code ~/dev ~/Dropbox/code ~/Dropbox/dev -mindepth 1 -maxdepth 1 -type d | fzf)

session_name=$(basename "$session" | tr . _)

echo "session: $session"
echo "session_name: $session_name"

if ! tmux has-session -t "$session_name" 2> /dev/null; then
    tmux new-session -s "$session_name" -c "$session" -d
fi

tmux switch-client -t "$session_name"
