#!/bin/sh

visible_line="================================================================"

echo "**** 📦 NPM updates ****"
npm update -g npm-check-updates
echo $visible_line

echo "**** 🦀 Rust updates ****"
rustup update stable
echo $visible_line

if [ "$(uname)" = "Darwin" ]; then
    echo "**** 🍎 macOS updates ****"

    brew update
    brew upgrade && brew upgrade --cask
    # Remove stale lock files and outdated downloads older than 120 days old
    brew cleanup
    # brew cleanup --prune=all --dry-run
    echo $visible_line

    # Update macOS itself
    # -i | --install    Install
    # -a | --all        All appropriate updates
    softwareupdate -ai
fi

if [ "$(uname)" = "Linux" ]; then
    echo "**** 🐧 Linux updates ****"

    # Update list of available packages
    sudo apt update
    # Do actual upgrade
    sudo apt upgrade -y
    # Remove unused dependencies
    sudo apt autoremove -y
    sudo apt autoclean
fi
