#!/usr/bin/env bash

# Check default shell
which "$SHELL"

echo "=============================== TERMINAL ================================"

echo "**** Modern core utils ****"
# Bat (better cat) - a cat clone with syntax highlighting and Git integration
brew install bat
# LSDeluxe (better ls) - ls with colors, icons, tree-view, etc.
brew install lsd
# Eza (better ls)
brew install eza

if [ "$(uname)" = "Darwin" ]; then
    echo "**** Nerd fonts ****"
    brew install --cask font-caskaydia-cove-nerd-font
    brew install --cask font-fira-code-nerd-font
    brew install --cask font-jetbrains-mono-nerd-font

    echo "**** alacritty - a fast, cross-platform, OpenGL terminal emulator ****"
    brew install --cask alacritty
    mkdir -p ~/.config/alacritty
    ln -nsf "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml

    echo "**** ghostty ****"
    brew install --cask ghossy
    ln -nsf "$DOTFILES/.config/ghostty" ~/.config/ghostty

    echo "**** kitty - the fast, feature-rich, GPU based terminal emulator ****"
    brew install --cask kitty
    ln -nsf "$DOTFILES/.config/kitty" ~/.config/kitty
fi

echo "**** tmux ****"
brew install tmux
sudo apt install -y tmux
tmux -V # capital V
mkdir -p ~/.config/tmux/plugins
# Tmux Plugin Manager (in non standard directory)
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
ln -nsf "$DOTFILES/.config/tmux/tmux.conf" ~/.config/tmux/tmux.conf
mkdir -p "$HOME/.local/bin" # Ensure ./local/bin exists
ln -nsf "$DOTFILES/scripts/tmux-sessionizer.sh" ~/.local/bin/tmux-sessionizer

echo "================================ ZSH ===================================="

if [ "$(uname)" = "Linux" ]; then
    # Nerd fonts
    sudo apt install -y fonts-firacode
    sudo apt install -y fonts-cascadia-code # Minimum Debian 11 and Ubuntu 20.04

    sudo apt update
    sudo apt install -y zsh
    zsh --version
    # Set ZSH as default shell
    chsh -s "$(which zsh)"
    # Verify the change of shell
    echo "$SHELL"
fi

if [ "$(uname)" = "Darwin" ]; then
    brew install spaceship
fi

# Antigen - The plugin manager for zsh.
curl -L git.io/antigen >~/.config/antigen.zsh
antigen update # Update all bundles
antigen selfupdate # Update antigen itself
antigen list # List currently running bundles
antigen version

mkdir -p "$HOME/.config/zsh/"
mkdir -p "$XDG_STATE_HOME"/zsh/
ln -nsf "$DOTFILES/shell/.shellrc.sh" ~/.shellrc.sh

# Add source line to config files only if it doesn't already exist
if ! grep -q "source.*shell/.shellrc.sh" ~/.zshrc 2>/dev/null; then
    echo "source \"$DOTFILES/shell/.shellrc.sh\"" >>~/.zshrc
fi
if ! grep -q "source.*shell/.shellrc.sh" ~/.config/zsh/.zshrc 2>/dev/null; then
    echo "source \"$DOTFILES/shell/.shellrc.sh\"" >>~/.config/zsh/.zshrc
fi
if ! grep -q "source.*shell/.shellrc.sh" ~/.bashrc 2>/dev/null; then
    echo "source \"$DOTFILES/shell/.shellrc.sh\"" >>~/.bashrc
fi

source ~/.zshrc
