#!/bin/sh

if [[ $(uname) == "Darwin" ]]; then
    echo "macOS detected"

    brew update
    brew upgrade && brew upgrade --cask
    brew cleanup
    brew cleanup --prune=all --dry-run
    softwareupdate -ai
fi

if [[ $(uname) == "Linux" ]]; then
    echo "Linux detected"

    # Update list of available packages
    sudo apt update 
    # Do actual upgrade
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean
    # sudo apt full-upgrade
    # sudo apt-get dist-upgrade
    # sudo do-release-upgrade
fi