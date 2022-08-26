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

echo "**** GIT ****"
brew install git
git config --global user.name "PauliusU"
git config --global user.email "48020370+PauliusU@users.noreply.github.com"
git config --global core.autocrlf input # line endings for OS compatability
git --version

echo "**** JetBrains Toolbox ****"
brew install jetbrains-toolbox

echo "**** MongoDB compass ****"
brew install mongodb-compass

echo "**** Python [Python 3] ****"
brew install python # defaults to python3
python3 --version
brew install pipenv
pipenv --version

echo "**** Visual studio code [VSCode] ****"
brew install visual-studio-code
code -v

echo "**** TypeScript, JavaScript, Node, NPM, yarn, Volta ****"
brew install volta
volta -v

volta install node@14
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

echo "**** Better shortcuts with Karabiner Elements and Hammerspoon ****"
# brew install karabiner-elements # remap the keys on a Mac at the kernel level.
brew install --cask hammerspoon

echo "**** MPV ****"
# brew install mpv # did not work for me
sudo port install mpv

echo "**** OBS Studio ****"
brew install --cask obs

echo "**** Images ****"
# sudo port install nomacs
brew install xnviewmp

echo "================================ ZSH ===================================="

echo "**** oh-my-zsh ****"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "**** zsh-completions ****"
brew install zsh-completions

# Copy ZSH aliases file to home
rm -f ~/.zsh_aliases
cp .zsh_aliases ~/

echo "
export BREW_HOME="$HOME/bin/homebrew"
export VOLTA_HOME="$HOME/.volta"
export PATH="$BREW_HOME/bin:$VOLTA_HOME/bin:$PATH"

# Load aliases
. ~/.zsh_aliases
" >>~/.zshrc

source ~/.zshrc
