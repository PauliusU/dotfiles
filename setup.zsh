#!/bin/zsh

# Symlinks for common files and folders. -f forces linking if file aready exists.
ln -sf ~/Dropbox/code ~/code
ln -sf ~/Dropbox/dev ~/devs

source $(dirname "$0")/scripts/file-system.zsh
source $(dirname "$0")/scripts/install-soft.zsh
source $(dirname "$0")/scripts/file-associations.zsh
source $(dirname "$0")/scripts/settings-macos.zsh
