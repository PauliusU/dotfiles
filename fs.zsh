#!/bin/zsh

# File system
python3 ~/code/OS-config/fs_dropbox_ignore_node_modules.py
python3 ~/code/OS-config/fs_long_path_names_checker.py

# Software updates
brew update && brew upgrade && brew upgrade --cask && brew cleanup
softwareupdate -ai
