echo ".aliases.sh"

# Navigation and file listing
alias -- -='cd -' # Toggle between last two directories with single dash '-'
alias cde="cd ~/code/"
alias cl="cd $CLOUD_STORAGE"
alias desk="cd ~/Desktop/"
alias dev="cd ~/dev/"
alias dl="cd ~/Downloads/"
alias docs="cd ~/Documents/"
alias dot="cd $DOTFILES"
alias drb="cd ~/Dropbox/"
alias ds="cd ~/Dropbox/DropsyncFiles"
alias dt="cd ~/Desktop/" # "dt" is also a command line tool to display information about your domain on Linux or Unix system
alias dwn="cd ~/Downloads/"
alias prj="cd ~/Dropbox/projects/"
# Save and then change the current directory. With no arguments, pushd exchanges the top two directories.
alias pu="pushd"
# Remove the top entry from the directory stack, and cd to the new top directory.
alias po="popd"
alias zz="cd -" # Toggle between last two directories
# Always list directory contents upon "cd"
function cd() {
    z "$@" || builtin cd "$@" || return 1 # If cd fails, don't try to run ls
    ls -A                       # List entries starting with ., but do not list implied . and ..
}
if [ -n "$ZSH_VERSION" ]; then
    # ZSH suffix aliases
    alias -s log="tail -f"
    alias -s txt="open -t"
fi
# If running bash
if [ -n "$BASH_VERSION" ]; then
    alias ....="cd ../../.."
    alias ...="cd ../.."
    alias ..="cd .."
fi

# Software management
alias bc="brew cleanup" # Remove old versions of installed software
alias bi="brew install"
alias bl="brew list"
alias br="brew reinstall"
alias bs="brew search"
alias bsl="brew services list"
alias bss="brew services stop"
alias bu="brew update && brew upgrade && brew upgrade --cask && brew cleanup"
alias bunn="brew uninstall"
alias bunnn="brew uninstall --ignore-dependencies"
alias bupc="brew upgrade --cask" # Upgrade all casks installed with homebrew
alias bupd="brew update"         # Update homebrew itself and the package lists
alias bupg="brew upgrade"        # Upgrade all software installed with homebrew
alias sysu="softwareupdate -ai"  # Run all macOS updates for Xcode, etc..
if [[ $(uname) == "Linux" ]]; then
    alias ai="sudo apt install"
    alias ar="sudo apt remove"
    alias aun="sudo apt remove"     # (a)pt (un)install
    alias arr="sudo apt autoremove" # Remove packages are no longer needed as dependencies
    alias as="sudo apt search"
    alias acs="apt-cache search"
    alias au="sudo apt update"     # Update repositories
    alias ag="sudo apt upgrade -y" # Update software (packages)
    alias auu="sudo apt update && sudo apt upgrade -y"
fi

# Git
alias gcca="git config --list"                                                          # Show git config
alias gccg="git config --list --global"                                                 # Show global git config
alias gccl="git config --list --local"                                                  # Show local git config
alias gll="git log --pretty='%C(yellow)%h %Creset%C(cyan)%ar %C(green)%an %C(reset)%s'" # Prettier git log. "gl" is alias for "git pull" in git plugin
alias gpp="git push && git push --tags"                                                 # Push commits and tags
alias gs="git status -s -b"                                                             # Cleaner git status
alias gw="git config --get core.isWork || echo false"                                   # Check if work config is applied
alias gcontr="git shortlog -s -n"                                                       # Contributors list. ref: https://makandracards.com/makandra/15909-quick-git-contributors-list
# Lazygit
alias lg="lazygit"
# GitHub CLI
alias ghh="gh browse"  # Open GitHub repo in browser
alias ghp="gh pr list" # List pull requests
# JS/TS, npm, yarn
alias ncul="ncu --target lastest"         # Show available depenecy updates with breaking changes
alias ncuu="ncu --upgrade --target minor" # Upgrade to non breaking dependency versions (minor and bugfixes) in package.json
alias npmg="npm list -g --depth 0"        # List global packages
alias nb="npm run build"
alias nd="npm run dev"
alias ndd="tsc -w -p tsconfig.build.json"
alias ni="npm install"
alias nl="npm run lint"
alias ns="npm run start"
alias nt="npm run test"
alias nti="npm run test:integration"
alias nu="npm run build && npm run lint && npm run test && npm run test:integration"
alias yyb="yarn build"
alias yyd="yarn dev"
alias yyg="yarn global list"
alias yyl="yarn lint"
alias yys="yarn start"
alias yyt="yarn test"
alias yytt="yarn test:integration"
alias yyu="yarn lint && yarn test"
alias yyy="yarn install --check-files"
alias pi="pnpm install && rm -f pnpm-lock.yaml"
alias pii="pnpm install"
alias bii="bun install --no-save"
alias bt="bun test"
# Python, pip and jupyter
alias py="python || python3"
alias py3="python3"
alias python="python3"
alias pipi="PIP_REQUIRE_VIRTUALENV=false && pip install --upgrade --user" # Install package in user scope
alias pipl="pip list --user"                                              # List user packages
alias pipll="pip list"                                                    # List global packages
alias jn="jupyter notebook"
alias jl="jupyter lab"
alias pve="python -m venv venv && source venv/bin/activate" # Create virtual environment
# Pipenv
alias peg="pipenv graph"                                 # Dependency graph
alias peh="pipenv --where"                               # Project home path
alias pei="pipenv install"                               # Install dependencies
alias per="pipenv run"                                   # Run a command in the virtual environment without launching a shell
alias perm="pipenv --rm"                                 # Remove virtual environment
alias pes="pipenv shell"                                 # Activate virtual environment
alias pess='[ -z \"$PIPENV_ACTIVE\" ] && echo \"false\"' # Check if pipenv environment is activated
alias peu="pipenv update"                                # Update all or specified dependencies
alias peun="pipenv uninstall"                            # Uninstall dependency
alias pew="pipenv --venv"                                # Check location of the environment
# Rust
alias ca="cargo add"
alias cb="cargo build"
alias cbb="cargo build --release"
alias cr="cargo run"
alias ct="cargo test"
alias cw="cargo watch -x run"             # Watch for changes and run. Requires cargo install cargo-watch
alias cww="cargo watch -q -c -x 'run -q'" # Watch for changes and run (without noisy output)
# Docker
alias da='docker attach'                                                                                  # Get back to running container
alias dcls='docker compose ls -a'                                                                         # List running compose projects
alias ddr='docker run -it --rm --name disposable'                                                         # Run any disposable container and delete it after exiting
alias ddru='docker run -it --rm --name disposable-ubuntu ubuntu:23.04 || docker attach disposable-ubuntu' # Run Ubuntu container and automatically delete it when it exits
alias dei='docker exec -it'                                                                               # Docker run interactive shell
alias dls='docker images'                                                                                 # See downloaded images = docker image ls
alias dnls='docker network ls'                                                                            # List docker networks
alias dps='docker ps --format="$DOCKER_FORMAT"'                                                           # See running containers = docker container ls
alias dpss='docker ps -a --format="$DOCKER_FORMAT"'                                                       # See all containers (not only those that run) = docker container ls -a
alias drn='docker run -w /src -v $PWD:/src --rm node:18'                                                  # Run Node commands without installing it. "-w /src" - creates folder inside a container.
alias dru='docker start -i ubun || docker run -it --name ubun -v ubuntu_data:/home pu/ubuntu fish'        # Run custom Ubuntu container (create it if needed)
alias dst='open -a Docker'                                                                                # Docker [st]art daemon
alias dstop='docker stop $(docker ps -a -q)'                                                              # Docker stope all containers
alias dvls='docker volume ls'                                                                             # List docker volumes
export DOCKER_FORMAT='ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n'

# Shell control
alias __="append_less_pipe"                      # Add "| less" to passed param
alias af="alias | fzf"                           # Fuzzy find in aliases
alias ag="alias | grep"                          # Quick search in aliases
alias brc='$EDITOR ~/.bashrc'                    # Bash config
alias c="clear"                                  # Clear shell screen
alias cls="clear"                                # Or user keyboard shortcut Command + K { # K }
alias ee="exit"                                  # Quit shell (one of alternative aliased)
alias ef="env | fzf"                             # Fuzzy find environment variables
alias fn='find . -name'                          # Find by given NAME
alias fnd='find . -type d -name'                 # Find by given NAME
alias fnf='find . -type f -name'                 # Find by given NAME
alias l="ls -A"                                  # List entries starting with ., but do not list implied . and ..
alias ls="lsd --group-dirs first"                # Use ls deluxe (lsd) instead of ls
alias ll="ls -Al"                                # All files and folders in table format
alias p="pwd"                                    # Print working directory
alias pe='printenv'                              # Print environment variables
alias reload="source ~/.zshrc"                   # ZSH settings reload
alias rr='clear && exec ${SHELL} -l'             # Reload the shell
alias s="sudo"                                   # Sudo shorthand
alias split_path='echo "$PATH" | sed "s/:/\n/g"' # Display PATH over multiple lines.
alias xx='exit'                                  # Quit shell (one of alternative aliased)
alias zrc='$EDITOR ~/.zshrc'                     # ZSH config
alias zsh-list="bindkey -L"                      # List ZSH keybindings

# Sensible defaults (same command but with different default value)
alias df="df -h"                # Human readable
alias du="du -h"                # Human readable
alias htop="htop -t"            # Processes in an indented tree - control+C to stop
alias rm='rm -i'                # Prompt before every removal
alias cp='cp -i'                # Prompt before overwrite
alias mv='mv -i'                # Prompt before overwrite
alias mount='mount | column -t' # Make mount command output pretty and human readable format

# System control (startup, restart, shutdown, cron jobs)
alias crn="crontab -e"                                    # Edit current crontab
alias restart="sudo shutdown -r now"                      # Requires root password, disable it by sudo chmod u+s /sbin/shutdown
alias services="systemctl list-unit-files | grep enabled" # List enabled services (Linux, WSL)
alias shutdown="sudo shutdown -h now"                     # Requires root password, disable it by sudo chmod u+s /sbin/shutdown
alias startup="gnome-session-properties"                  # Startup applications (Linux)

# Program access
alias bw="bwm-ng -d"                                                                           # Network speed with dynamic units like K, M or G
alias cdd="code ."                                                                             # Open current folder in VS Code
alias chx="chmod +x"                                                                           # Make file executable
alias deb="sudo dpkg -i"                                                                       # Install deb package (for Ubuntu, Debian, Raspbian)
alias ff="fd -IH"                                                                              # File system search. Include 1. .gitignore and 2. hidden files
alias fdd="fd -IH --type d"                                                                    # Search directories
alias hf='cat $HISTFILE | fzf'                                                                 # Fuzzy find in command history
alias m='mpv'                                                                                  # MPV media player
alias mpp=mpv_detached                                                                         # Run MPV in detached mode
alias md='mkdir'                                                                               # Make directory
alias n='nvim'                                                                                 # Neovim
alias nv='if [ -f "./src/index.ts" ]; then nvim "./src/index.ts"; else nvim; fi'               # Neovim (open index.ts if exists)
alias oo=open_in_file_explorer                                                                 # Open current folder in file explorer
alias rmm="rm -rf"                                                                             # Remove non-empty folder
alias space="du -sh"                                                                           # Space used by current folder (and subfolders)
alias taru='tar xzvf'                                                                          # Unzip
alias tarx="tar -xvf"                                                                          # Unzip
alias tarz='tar czvf'                                                                          # Zip
alias td="tmux detach"                                                                         # Exit the tmux window to come back to later
alias tls="tmux ls"                                                                            # = tmux list-sessions
alias tmks="tmux kill-server"                                                                  # Cleanly and gracefully kill all tmux open sessions (and server)
alias tmm='echo tmux: $TMUX'                                                                   # = tmux new = tmux new-session
alias tmx="tmux new-session -ADs main"                                                         # Create "main" session or attach to it (if exists) ref: https://github.com/threkk/dotfiles/blob/d1c3c6681286e3e289d04f64a8ffb37fdbdbbc98/dotfiles/alias
alias tt="tmux switch -t main || tmux new -As main"                                            # Switch to "main" session or create it if needed
alias tg="tmux switch -t dotfiles || tmux new -s dotfiles -c $DOTFILES -d && tmux switch -t dotfiles"                     # Switch to "dotfiles" session
alias v='$BREW_HOME/bin/vim'                                                                   # Shorthand for vim
alias vi='$BREW_HOME/bin/vim'                                                                  # Shorthand for vim
alias vim="nvim"                                                                               # Replace vim with neovim
alias y="yazi"                                                                                 # Yazi file manager
alias yta="yt-dlp -x --audio-format aac --restrict-filenames --add-metadata --embed-thumbnail" # YouTube audio

# Time and Date
alias fulldate="date +%F"                                                          # Date in YYYY-MM-DD format
alias week="date +%V"                                                              # Get week number
alias timer="echo 'Timer started. <ctrl+d> to break.' && date && time cat && date" # Stopwatch

# Network
alias ip="curl icanhazip.com"                                       # External IP
alias ipi="ifconfig | grep inet | grep -v inet6 | awk '{print $2}'" # Internal IPs

# Scripts and functions
alias di='python3 $DOTFILES/scripts/fs_dropbox_ignore_node_modules.private.py'
alias fss='$DOTFILES/scripts/fs.sh'
