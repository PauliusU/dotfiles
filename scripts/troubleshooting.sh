#!/bin/sh

# Toubleshoot system problems by reseting settings and cleaning up the software

# Reset xcode developer path
sudo xcode-select --reset

# Reset all "Accessibility" settings
sudo tccutil reset Accessibility
# Reset all "Full disk access" settings
sudo tccutil reset SystemPolicyAllFiles
# Reset macOS permissions for Alfred
reset All com.runningwithcrayons.Alfred

# Uninstall all apps from macports
sudo port -fp uninstall installed
port installed

# Neovim
rm -rf ~/.local/share/nvim
rm -rf ~/.config/nvim/*

if [[ $(uname) == "Linux" ]]; then
    sudo apt -y autoremove
    sudo apt -y autoclean
    sudo apt -y clean
fi
