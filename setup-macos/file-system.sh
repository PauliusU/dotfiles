#!/bin/sh

echo "**** File system setup ****"

# User folders
mkdir -p ~/bin
mkdir -p ~/repos
mkdir -p ~/scripts

# Symlinks for common files and folders. -f forces linking if file aready exists
ln -nsf ~/Dropbox/code ~/code
ln -nsf ~/Dropbox/dev ~/dev
ln -nsf ~/Dropbox/projects ~/projects
ln -nsf ~/Library/CloudStorage ~/storage

if [[ "$(uname -sr)" == "Linux"*"microsoft"* ]]; then
    echo "**** WSL setup ****"
    ln -nsf /mnt/d/Dropbox ~/Dropbox
    ln -nsf /mnt/d/Dropbox/code ~/code
    ln -nsf /mnt/d/Dropbox/dev ~/dev
fi
