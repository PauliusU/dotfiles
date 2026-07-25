#!/bin/bash

# File system maintenance script: cleanup, backup, cache pruning, cloud sync, and updates

echo "**** 🗃️ File system ****"
python3 "$DOTFILES/scripts/fs_long_path_names_checker.private.py"
tsx "$DOTFILES/scripts/private/file-mover.ts"
source "$DOTFILES/scripts/fs-cleanup.periodical.private.sh"
source "$DOTFILES/scripts/fs-cloud-sync.private.sh"
echo ""

echo "**** ⚡ Unused caches ****"
pnpm store prune
echo ""

echo "**** 🔄 Software updates ****"
source "$DOTFILES/scripts/updater.sh"
echo ""
