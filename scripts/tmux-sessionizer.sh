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

# Exit gracefully if user cancelled fzf selection
if [[ -z "$session_path" ]]; then
    exit 0
fi

if ! command -v tmux &>/dev/null; then
    echo "tmux is not installed. Switching path to $session_path"
    cd "$session_path" || exit 1
    exit 0
fi

tmux_running=$(pgrep tmux)

# Base folder name with underscores instead of dots
session_name=$(basename "$session_path" | tr . _)

# Switches to tmux session, handling both inside and outside tmux contexts
# Uses attach-session when outside tmux, switch-client when inside tmux
switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

# Runs project-specific .tmux-ready script if it exists
# Useful for starting dev servers, activating environments, etc.
hydrate() {
    if [[ -f "$session_path/.tmux-ready" ]]; then
        tmux send-keys -t "$session_name" "./.tmux-ready" C-m
    fi
}

echo "session_name: $session_name"
echo "session_path: $session_path"

# If tmux isn't running at all, create non-detached session
if [[ -z "$TMUX" ]] && [[ -z "$tmux_running" ]]; then
    echo "No tmux running. Creating new session: $session_name"
    tmux new-session -s "$session_name" -c "$session_path"
    exit 0
fi

# Create detached session if it doesn't exist
if ! tmux has-session -t "$session_name" 2>/dev/null; then
    echo "tmux session does not exist, creating it"
    tmux new-session -ds "$session_name" -c "$session_path"
fi

# Switch to session and run hydration
switch_to "$session_name"
hydrate
