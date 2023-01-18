#!/usr/bin/env bash

# Symlinks for common files and folders. -f forces linking if file aready exists.
ln -sf ~/Dropbox/code ~/code
ln -sf ~/Dropbox/dev ~/dev

if [[ "$(uname -sr)" == "Linux"*"microsoft"* ]]; then
    echo "WSL found"
    ln -sf /mnt/d/Dropbox ~/Dropbox
    ln -sf /mnt/d/Dropbox/code ~/code
    ln -sf /mnt/d/Dropbox/dev ~/dev
fi

source $(dirname "$0")/scripts/file-system.zsh
source $(dirname "$0")/scripts/install-soft.zsh
source $(dirname "$0")/scripts/file-associations.zsh
source $(dirname "$0")/scripts/settings-macos.zsh
