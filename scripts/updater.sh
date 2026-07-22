#!/bin/sh

visible_line="================================================================"

echo "**** 📦 NPM and PNPM updates ****"
npm list -g --depth=0 --long
npm update -g npm-check-updates
npm update -g typescript
pnpm self-update
echo $visible_line

echo "**** 🟠 Claude Code update ****"
claude update
echo $visible_line

echo "**** 🖱️  Cursor Agent update ****"
# Official installer, not brew (brew cask hits macOS Gatekeeper). https://cursor.com/cli
cursor-agent update
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
    brew upgrade -y
    # Upgrade all installed casks, even those that are marked as "auto_updates: false" or "version :latest"
    brew upgrade --cask --greedy -y
    # Remove stale lock files and outdated downloads older than 120 days old
    brew cleanup
    # brew cleanup --prune=all --dry-run
    echo $visible_line

    # Update Microsoft Office (Word/Outlook/OneDrive) — NOT Homebrew-managed. MAU is
    # set to Manual mode (no login-time checks), so updates run here via the msupdate CLI.
    msupdate_cli="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    if [ -x "$msupdate_cli" ]; then
        echo "**** Ⓜ️  Microsoft Office updates ****"
        # --list first: a bare --install times out on a cold MAU daemon
        "$msupdate_cli" --list
        "$msupdate_cli" --install --wait 300
    fi
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
