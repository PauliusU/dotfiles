#!/bin/bash

echo "**** File system ****"
$DOTFILES/scripts/private/dropboxIgnore.js
$DOTFILES/scripts/fs_dropbox_ignore_node_modules.private.py
$DOTFILES/scripts/fs_long_path_names_checker.private.py

echo "**** Backup ****"
rsync -av --delete $HOME/Library/Preferences/doublecmd/ $HOME/Dropbox/linked/backup/doublecmd

echo "**** Software updates ****"
npm install -g npm-check-updates
$DOTFILES/scripts/updater.sh
