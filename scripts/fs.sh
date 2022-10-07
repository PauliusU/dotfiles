#!/bin/bash

# File system
python3 ~/code/dotfiles/scripts/fs_dropbox_ignore_node_modules.py
python3 ~/code/doftiles/scripts/fs_long_path_names_checker.py

# Software updates
brew update && brew upgrade && brew upgrade --cask && brew cleanup
softwareupdate -ai
