#!/usr/bin/env bash

# Check default shell
which $SHELL

echo "=============================== TERMINAL ================================"

if [[ $(uname) -eq "Darwin" ]]; then
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
    sudo apt update

    sudo apt install -y zsh
    # Set ZSH as  default shell
    chsh -s $(which zsh)

    sudo apt install -y curl
    # Oh My Zsh is an extension to Zsh that will allow you to easily customise your prompt to add themes, plugins and shortcuts
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # The easiest way to install and manage Oh My Zsh plugins is via a package manage
    curl -L git.io/antigen >~/.config/antigen.zsh
    # source ~/.config/antigen.zsh

    # Nerd fonts
    sudo apt install -y fonts-cascadia-code # minimum Debian 11 and Ubuntu 20.04
fi

# echo "**** oh-my-zsh ****"
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# echo "**** zsh-completions ****"
# brew install zsh-completions

if [[ $(uname) -eq "Darwin" ]]; then
    echo "**** Spaceship Prompt (and fira-code font) ****"

    brew tap homebrew/cask-fonts
    brew install --cask font-fira-code
    brew install --cask font-fira-code-nerd-font
    brew install --cask font-cascadia-code-pl
    brew install --cask font-caskaydia-cove-nerd-font

    sudo apt install -y fonts-firacode
    sudo apt install -y fonts-cascadia-code

    # brew install spaceship
    # echo "source $(brew --prefix)/opt/spaceship/spaceship.zsh" >>! ~/.zshrc
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    # Set ZSH_THEME="spaceship" in your .zshrc.
fi

ln -sf $(pwd)/terminal/.aliases ~/.aliases
ln -sf $(pwd)/terminal/.shellrc ~/.shellrc
echo "source ~/.shellrc" >>~/.zshrc
echo "source ~/.shellrc" >>~/.bashrc

source ~/.zshrc
