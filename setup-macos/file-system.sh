#!/bin/sh

echo "**** File system setup ****"

# User folders
mkdir -p ~/bin
mkdir -p ~/repos
mkdir -p ~/scripts

# Symlinks for common files and folders. -f forces linking if file aready exists
ln -sf ~/Dropbox/code ~/code
ln -sf ~/Dropbox/dev ~/dev
ln -sf ~/Dropbox/projects ~/projects
ln -sf ~/Library/CloudStorage ~/storage

if [[ "$(uname -sr)" == "Linux"*"microsoft"* ]]; then
    echo "**** WSL setup ****"
    ln -sf /mnt/d/Dropbox ~/Dropbox
    ln -sf /mnt/d/Dropbox/code ~/code
    ln -sf /mnt/d/Dropbox/dev ~/dev
fi