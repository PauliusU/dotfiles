#!/bin/zsh

echo "=========================== BREW [NON ADMIN] ============================"
mkdir -p ~/bin
cd ~/bin
mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"

brew --version
brew update  # update brew itself
brew upgrade # update packages (installed programs)

echo "=============================== DEV TOOLS ==============================="

echo "**** AWS CLI ****"
brew install awscli
aws --version

echo "**** Docker ****"
brew install --cask docker # Docker desktop
docker -v

echo "**** GIT ****"
brew install git
git config --global user.name "PauliusU"
git config --global user.email "48020370+PauliusU@users.noreply.github.com"
git config --global core.autocrlf input # line endings for OS compatability
ln -s $(pwd)/.gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
git --version

echo "**** JetBrains Toolbox ****"
brew install jetbrains-toolbox

echo "**** MongoDB compass ****"
brew install --cask mongodb-compass

echo "**** Neovim / Vim ****"
brew install neovim
# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

brew install vim
# Install vim-plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "**** Python [Python 3] and artificial intelligence ****"
brew install python # defaults to python3
python3 --version
python3 -m pip install --upgrade pip

brew install pipenv
pipenv --version

brew install --cask miniconda
# Update conda itself
conda --version
conda update conda
conda --version
# Clean previous environments (if any)
conda install anaconda-clean
anaconda-clean --yes
# Create commonly used environments
conda create --name ml python=3.9 jupyter numpy pandas tensorflow tensorflow_datasets
conda create --name ml-mac python=3.9 jupyter numpy pandas tesnsorflow-macos tensorflow-metal tensorflow_datasets
conda create -n tf tensorflow tensorflow_datasets
conda create -n tf-gpu tensorflow-gpu tensorflow_datasets
conda create -n tf-mac tesnsorflow-macos tensorflow-metal

echo "**** Visual studio code [VSCode] ****"
brew install --cask visual-studio-code
code -v

echo "**** TypeScript, JavaScript, Node, NPM, yarn, Volta ****"
brew install volta
volta -v

volta install node@16
# volta pin node@16
# volta uninstall node is not supported. Remove node version from ~/.volta/tools/image/node/ istead
volta list node
volta which node
node -v
volta install yarn
yarn -v
volta install npm # update oudated version installed with Node v14
npm -v
npm install --global typescript
tsc -v
npm i -g ts-node
ts-node -v
volta list

echo "=========================== OTHER PROGRAMS =============================="

echo "**** 7zip ****"
# p7zip is the command line version of 7-Zip for Linux / Unix, made by an independent developer.
brew install p7zip # Posix 7zip (older version). Acessible using "7z"
7z -version
brew install 7zip # Latest version. Acessible using "7zz"
7zz -version

echo "**** AltTab - Windows alt-tab on macOS ****"
brew install --cask alt-tab

echo "**** Rectangle - must have window manager ****"
brew install --cask rectangle

echo "**** Dropbox sync ****"
brew install dropbox # official client (takes up device spot)
# brew install maestral # does not take device spot, but slower sync

echo "**** Duti - file association manager ****"
brew install duti
duti -V # capital V

echo "**** File search (everything alternatives) ****"
brew install easyfind
# sudo port install recoll # cluncy design

echo "**** Keyboard and automation (shortcuts, text expansion) ****"
# Better shortcuts with Karabiner Elements and Hammerspoon
brew install karabiner-elements # free, open source, mac. Remap the keys on a Mac at the kernel level. Ex KeyRemap4MacBook
brew install --cask hammerspoon # free, open source, mac

# Espanso. Free, open source, cross-platform
brew tap espanso/espanso # Add espanso tap, because Espanso is hosted outside the core homebrew repository
brew install espanso
espanso path
# espanso edit # open espanso configuration file in editor
# espanso install basic-emojis
espanso package list # List installed espanso packages
espanso package update all # Update all packages
espanso --version

# ### macOS built-in options ####
# Script Editor (called AppleScript Editor from 2009 to 2014) for the AppleScript and Javascript
#       plain text (.applescript), as a compiled script (.scpt), as a script bundle (.scptd), or as an application (.app).
# Automator # built-in in macOS since 10.4
# Shortcuts / apple shortcuts / siri shortcuts (formerly Workflow). Syncs with iPhone.

# Other autmation options
brew install keyboard-maestro # paid, mac only
brew install textexpander # paid, cross-platform

echo "**** File management ****"
brew install --cask marta # Marta File Manager for macOS. Native. Extensible. Fast. 🚀
brew install --cask double-commander
brew install midnight-commander

echo "**** MPV ****"
# brew install mpv # did not work for me
sudo port install mpv

echo "**** OBS Studio ****"
brew install --cask obs

echo "**** Images ****"
# sudo port install nomacs
brew install xnviewmp

echo "**** yt-dlp ****"
brew install yt-dlp

echo "=============================== TERMINAL ================================"

echo "**** iterm2 - Terminal.app replacement ****"
brew cask install iterm2

echo "**** tmux ****"
brew install tmux
tmux -V # Capital V

echo "================================ ZSH ===================================="

# echo "**** oh-my-zsh ****"
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# echo "**** zsh-completions ****"
# brew install zsh-completions

echo "**** Spaceship Prompt (and fira-code font) ****"
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-cascadia-code-pl
# brew install spaceship
# echo "source $(brew --prefix)/opt/spaceship/spaceship.zsh" >>! ~/.zshrc
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# Set ZSH_THEME="spaceship" in your .zshrc.


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
