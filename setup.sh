#!/usr/bin/env bash

echo "*** File system setup ***" 
mkdir -p ~/bin
mkdir -p ~/repos
mkdir -p ~/scripts
# Symlinks for common files and folders. -f forces linking if file aready exists
ln -sf ~/Dropbox/code ~/code
ln -sf ~/Dropbox/dev ~/dev
ln -sf ~/Library/CloudStorage ~/storage

if [[ "$(uname -sr)" == "Linux"*"microsoft"* ]]; then
    echo "Setting up WSL"
    ln -sf /mnt/d/Dropbox ~/Dropbox
    ln -sf /mnt/d/Dropbox/code ~/code
    ln -sf /mnt/d/Dropbox/dev ~/dev
fi

# source "$(dirname "$0")/setup-macos/file-system.sh"
source "$(dirname "$0")/setup-macos/install-soft.sh"
source "$(dirname "$0")/scripts/1-setup-scripts.sh"
source "$(dirname "$0")/terminal/terminal-and-shell.sh"
source "$(dirname "$0")/setup-macos/file-associations.sh"
source "$(dirname "$0")/setup-macos/settings-macos.sh"
source "$(dirname "$0")/setup-macos/dev-tools.sh"
