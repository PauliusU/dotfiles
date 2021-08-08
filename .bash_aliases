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

# System information
# List enabled services
alias systemctl-enabled="systemctl list-unit-files | grep enabled"
# Internal IP
alias myip="ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"

# Raspberry Pi - Check temperature and voltage
# alias temp="sudo /opt/vc/bin/vcgencmd measure_temp"
alias temp="vcgencmd measure_temp"
# alias volts="sudo /opt/vc/bin/vcgencmd measure_volts"
alias volts="vcgencmd measure_volts"