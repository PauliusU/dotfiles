#!/usr/bin/env bash

# Symlinks for common files and folders. -f forces linking if file aready exists.
ln -sf ~/Dropbox/code ~/code
ln -sf ~/Dropbox/dev ~/dev
ln -sf ~/Library/CloudStorage ~/storage

if [[ "$(uname -sr)" == "Linux"*"microsoft"* ]]; then
    echo "WSL found"
    ln -sf /mnt/d/Dropbox ~/Dropbox
    ln -sf /mnt/d/Dropbox/code ~/code
    ln -sf /mnt/d/Dropbox/dev ~/dev
fi

source "$(dirname "$0")/setup-macos/file-system.sh"
source "$(dirname "$0")/setup-macos/install-soft.sh"
source "$(dirname "$0")/setup-macos/file-associations.sh"
source "$(dirname "$0")/setup-macos/settings-macos.sh"
