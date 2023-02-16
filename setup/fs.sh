#!/bin/bash

# File system
python3 ~/code/dotfiles/scripts/fs_dropbox_ignore_node_modules.private.py
python3 ~/code/dotfiles/scripts/fs_long_path_names_checker.private.py

# Software updates
brew update && brew upgrade && brew upgrade --cask && brew cleanup
softwareupdate -ai
