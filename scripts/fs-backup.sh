#!/bin/sh

# RSYNC:
# -a, --archive     a combination flag, equals -rlptgoD (no -H,-A,-X). Syncs
#                   recursively and preserves symbolic links, special and device
#                   files, modification times, groups, owners, and permissions
# -v, --verbose     increase verbosity
# -n, --dry-run     show what would have been transferred
# --delete          delete extraneous files from destination dirs
# --progress        show progress percentage during transfer. Useful for large files
# --mkpath          create the destination path. Was added in rsync 3.2.3 (6 Aug 2020).

if [ -z "${PATH_BACKUP}" ]; then
    echo "❌ ERROR: Backup path env variable is not set"
    exit 1
fi

# Software settings
mkdir -p "$PATH_BACKUP/.config/"
rsync -av --delete "$HOME/.config/karabiner" "$PATH_BACKUP/.config"
rsync -av --delete "$HOME/Library/Preferences/doublecmd/" "$PATH_BACKUP/doublecmd"
