#!/bin/sh

echo "**** 📦 NPM updates ****"
npm update -g npm-check-updates

if [[ $(uname) == "Darwin" ]]; then
    echo "**** 🍎 macOS updates ****"

    brew update
    brew upgrade && brew upgrade --cask
    brew cleanup
    brew cleanup --prune=all --dry-run

    # Update macOS itself
    # -i | --install    Install
    # -a | --all        All appropriate updates
    softwareupdate -ai
fi

if [[ $(uname) == "Linux" ]]; then
    echo "**** 🐧 Linux updates ****"

    # Update list of available packages
    sudo apt update
    # Do actual upgrade
    sudo apt upgrade -y
    # Remove unused dependencies
    sudo apt autoremove -y
    sudo apt autoclean
fi
