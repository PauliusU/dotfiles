#!/bin/zsh

# check default shell
which $SHELL

echo "=============================== TERMINAL ================================"

if [[ $(uname) -eq "Darwin" ]]; then
    echo "**** iterm2 - Terminal.app replacement ****"
    brew install --cask iterm2
fi

echo "**** tmux ****"
brew install tmux
tmux -V # Capital V

echo "================================ ZSH ===================================="

if [[ $(uname) -eq "Linux" ]]; then
    sudo apt-get update
    sudo apt-get install zsh
    # Set ZSH as  default shell
    chsh -s $(which zsh)
    sudo apt-get install curl
    # Oh My Zsh is an extension to Zsh that will allow you to easily customise your prompt to add themes, plugins and shortcuts
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # The easiest way to install and manage Oh My Zsh plugins is via a package manage
    curl -L git.io/antigen >~/antigen.zsh
    # source ~/antigen.zsh

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
    brew install --cask font-cascadia-code-pl
    # brew install spaceship
    # echo "source $(brew --prefix)/opt/spaceship/spaceship.zsh" >>! ~/.zshrc
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    # Set ZSH_THEME="spaceship" in your .zshrc.
fi

# Copy ZSH aliases file to home
rm -f ~/.zsh_aliases
cp .zsh_aliases ~/

echo "
# CUSTOM
export BREW_HOME="$HOME/bin/homebrew"
export VOLTA_HOME="$HOME/.volta"
export PATH="$BREW_HOME/bin:$VOLTA_HOME/bin:$PATH"

# Load aliases
. ~/.zsh_aliases
" >>~/.zshrc

source ~/.zshrc