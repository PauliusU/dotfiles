#!/usr/bin/env bash

echo "**** File system setup ****"

# User folders
mkdir -p ~/bin
mkdir -p ~/repos
mkdir -p ~/scripts

# Symlinks for common files and folders. -f forces linking if file already exists
if [ -n "$FS" ]; then
    ln -nsf "$FS/dev" ~/dev
    ln -nsf "$FS/github" ~/github
    ln -nsf "$FS/notes" ~/notes
    ln -nsf "$FS/projects" ~/projects
fi
ln -nsf ~/Library/CloudStorage ~/storage

if [[ "$(uname -sr)" == "Linux"*"microsoft"* ]]; then
    echo "**** WSL setup ****"
    ln -nsf /mnt/d/Dropbox ~/Dropbox
    ln -nsf /mnt/d/Dropbox/github ~/github
    ln -nsf /mnt/d/Dropbox/dev ~/dev
fi
