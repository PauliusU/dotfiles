#!/bin/sh

visible_line="================================================================"

echo "**** 📦 NPM and PNPM updates ****"
npm list -g --depth=0 --long
npm update -g npm-check-updates
npm update -g typescript
pnpm self-update
echo $visible_line

echo "**** 🦀 Rust updates ****"
rustup update stable
cargo install --list
echo $visible_line

echo "**** 🐍 Python and pipx updates ****"
pipx upgrade-all
echo $visible_line

if [ "$(uname)" = "Darwin" ]; then
    echo "**** 🍎 macOS updates ****"

    brew update
    # Upgrade outdated packages (called "formulae" in Homebrew terminology)
    brew upgrade
    # Upgrade all installed casks, even those that are marked as "auto_updates: false" or "version :latest"
    brew upgrade --cask --greedy
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
