# Package management
alias ai='sudo apt install'
alias ar='sudo apt remove'
alias arr='sudo apt autoremove' # remove packages are no longer needed as dependencies
alias as='sudo apt search'
alias au='sudo apt update' # updates repositories
alias ag='sudo apt upgrade -y' # updates software (packages)
alias auu='sudo apt update && sudo apt upgrade -y'

# Navigation and listing
alias ...='cd ../..'
alias ..='cd ..'
alias dt='cd ~/Desktop'
alias dwn='cd ~/Downloads'
alias la='ls -A' # list entries starting with ., but do not list implied . and ..
alias ll='ls -alF' # list entries with detailed info

# Default options
alias df='df -h' # human readable
alias du='du -h' # human readable