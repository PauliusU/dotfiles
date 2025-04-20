#!/bin/bash

echo "**** 🗃️ File system ****"
node "$DOTFILES/scripts/private/dropbox-ignore.js"
python3 "$DOTFILES/scripts/fs_dropbox_ignore_node_modules.private.py"
python3 "$DOTFILES/scripts/fs_long_path_names_checker.private.py"
tsx "$DOTFILES/scripts/private/file-mover.ts"
source "$DOTFILES/scripts/fs-cleanup.periodical.private.sh"
echo ""

echo "**** 💾 Backup ****"
source "$DOTFILES/scripts/fs-backup.sh"
echo ""

echo "**** 🔄 Software updates ****"
source "$DOTFILES/scripts/updater.sh"
