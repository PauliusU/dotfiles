#!/usr/bin/env bash

# This script automatically kills unused TMUX sessions

# Required for tmux ls command to run propperly
export PATH="/opt/homebrew/bin:$PATH"

TOO_OLD_THRESHOLD_MIN=1440 # 24 hours
TMUX_LOG_PATH="$LOGS/tmux-kill-sessions.log"

NOW=$(($(date +%s)))

tmux ls -F '#{session_name} #{session_activity}' | while read -r LINE; do
  SESSION_NAME=$(echo "$LINE" | awk '{print $1}')
  LAST_ACTIVITY=$(echo "$LINE" | awk '{print $2}')
  LAST_ACTIVITY_MINS_ELAPSED=$(((NOW - LAST_ACTIVITY) / 60))

  # Print all sessions
  echo "${SESSION_NAME} is ${LAST_ACTIVITY_MINS_ELAPSED}min"

  if [[ "$LAST_ACTIVITY_MINS_ELAPSED" -gt "$TOO_OLD_THRESHOLD_MIN" ]]; then
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$TIMESTAMP - Killed session: $SESSION_NAME (Inactive for ${LAST_ACTIVITY_MINS_ELAPSED}min) ❌" | tee -a "$TMUX_LOG_PATH"
    tmux kill-session -t "${SESSION_NAME}"
  fi
done
