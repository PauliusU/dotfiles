#!/usr/bin/env bash

# Check default shell
which $SHELL

echo "=============================== TERMINAL ================================"

if [[ $(uname) -eq "Darwin" ]]; then
    echo "**** Nerd fonts ****"
    brew tap homebrew/cask-fonts
    brew install --cask font-caskaydia-cove-nerd-font
    brew install --cask font-fira-code-nerd-font
    brew install --cask font-jetbrains-mono-nerd-font

    echo "**** iterm2 - Terminal.app replacement ****"
    brew install --cask iterm2

    echo "**** alacritty - a fast, cross-platform, OpenGL terminal emulator ****"
    brew install --cask alacritty
    mkdir -p ~/.config/alacritty
    ln -sf $(pwd)/terminal/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
fi

echo "**** tmux ****"
brew install tmux
sudo apt install -y tmux
tmux -V # Capital V
ln -sf $(pwd)/terminal/.tmux.conf ~/.tmux.conf
ln -sf $(pwd)/terminal/tmux-sessionizer.sh ~/.local/bin/tmux-sessionizer

echo "================================ ZSH ===================================="

if [[ $(uname) -eq "Linux" ]]; then
    # Nerd fonts
    sudo apt install -y fonts-firacode
    sudo apt install -y fonts-cascadia-code # minimum Debian 11 and Ubuntu 20.04

    sudo apt update
    sudo apt install -y zsh
    zsh --version
    # Set ZSH as default shell
    chsh -s $(which zsh)
    # Verify the change of shell
    echo $SHELL
fi

if [[ $(uname) -eq "Darwin" ]]; then
    brew install spaceship
fi

# Antigen - The plugin manager for zsh.
curl -L git.io/antigen >~/.config/antigen.zsh
antigen update # Update all bundles
antigen selfupdate # Update antigen itself
antigen list # List currently running bundles
antigen version

ln -sf $(pwd)/terminal/.aliases ~/.aliases
ln -sf $(pwd)/terminal/.shellrc ~/.shellrc
echo "source ~/.shellrc" >>~/.zshrc
echo "source ~/.shellrc" >>~/.bashrc

source ~/.zshrc
