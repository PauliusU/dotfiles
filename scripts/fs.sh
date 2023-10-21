#!/bin/bash

echo "**** File system ****"
node "$DOTFILES/scripts/private/dropboxIgnore.js"
python "$DOTFILES/scripts/fs_dropbox_ignore_node_modules.private.py"
python "$DOTFILES/scripts/fs_long_path_names_checker.private.py"

echo "**** Backup ****"
"$DOTFILES/scripts/fs-backup.sh"

echo "**** Software updates ****"
"$DOTFILES/scripts/updater.sh"
