#!/usr/bin/env bash

# Check if tmux is installed
if ! command -v tmux &>/dev/null; then
    echo "tmux is not installed. Please install tmux to use this script."
    exit 1
fi

# Get the list of tmux sessions
sessions=$(tmux ls 2>/dev/null)

# Check if there are any active sessions
if [ -z "$sessions" ]; then
    echo "No active tmux sessions found."
    exit 0
fi

# Use fzf to select a session
selected_session=$(echo "$sessions" | fzf --preview "echo {}" --preview-window=up:3)

# Check if a session was selected
if [ -z "$selected_session" ]; then
    echo "No session selected."
    exit 0
fi

# Extract the session name (first word before the colon)
session_name=$(echo "$selected_session" | awk -F: '{print $1}')

# Switch to the selected session
tmux switch-client -t "$session_name" 2>/dev/null || tmux attach-session -t "$session_name"h
