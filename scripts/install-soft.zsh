#!/bin/zsh

echo "=========================== BREW [NON ADMIN] ============================"
mkdir -p ~/bin
cd ~/bin
mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
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
ln -s $(pwd)/.gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
git --version
brew install --cask fork # git-fork git client

echo "**** GitHub CLI ****"
brew install gh
gh --version

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

echo "**** Go Goland ****"
brew install go
go version

echo "**** Rust ****"
brew install rust
rustc --version

if [[ $(uname) -eq "Darwin" ]]; then
    echo "**** Docker ****"
    brew install --cask docker # Docker desktop
    docker -v

    echo "**** JetBrains Toolbox ****"
    brew install --cask jetbrains-toolbox

    echo "**** MongoDB compass ****"
    brew install --cask mongodb-compass

    echo "**** Postman ****"
    brew install --cask postman

    echo "**** Visual studio code [VSCode] ****"
    brew install --cask visual-studio-code
    code -v

    echo "**** xcode ****"
    /usr/bin/xcodebuild -version
    clang --version
fi

echo "=========================== OTHER PROGRAMS =============================="

echo "**** 7zip ****"
# p7zip is the command line version of 7-Zip for Linux / Unix, made by an independent developer.
brew install p7zip # Posix 7zip (older version). Acessible using "7z"
7z -version
brew install 7zip # Latest version. Acessible using "7zz"
7zz -version

echo "**** File management ****"
brew install midnight-commander

echo "**** Fuzzy finder ****"
brew install fzf

if [[ $(uname) -eq "Darwin" ]]; then
    echo "**** Anki ****"
    brew install --cask anki

    echo "**** Dropbox sync ****"
    brew install --cask dropbox # official client (takes up device spot)
    # brew install maestral # does not take device spot, but slower sync

    echo "**** Duti - file association manager (macOs only) ****"
    brew install duti
    duti -V # capital V

    echo "**** File management ****"
    brew install --cask marta # Marta File Manager for macOS. Native. Extensible. Fast. 🚀
    brew install --cask double-commander

    echo "**** File search (everything alternatives) ****"
    brew install --cask easyfind
    # sudo port install recoll # cluncy design

    echo "**** Keyboard and automation (shortcuts, text expansion) ****"
    # Better shortcuts with Karabiner Elements and Hammerspoon
    brew install --cask karabiner-elements # free, open source, mac. Remap the keys on a Mac at the kernel level. Ex KeyRemap4MacBook
    brew install --cask hammerspoon        # free, open source, mac

    # Espanso. Free, open source, cross-platform
    brew tap espanso/espanso # Add espanso tap, because Espanso is hosted outside the core homebrew repository
    brew install --cask espanso
    espanso path
    # espanso edit # open espanso configuration file in editor
    # espanso install basic-emojis
    espanso package list       # List installed espanso packages
    espanso package update all # Update all packages
    espanso --version

    # ### macOS built-in options ####
    # Script Editor (called AppleScript Editor from 2009 to 2014) for the AppleScript and Javascript
    #       plain text (.applescript), as a compiled script (.scpt), as a script bundle (.scptd), or as an application (.app).
    # Automator # built-in in macOS since 10.4
    # Shortcuts / apple shortcuts / siri shortcuts (formerly Workflow). Syncs with iPhone.

    # Other autmation options
    brew install --cask keyboard-maestro # paid, mac only
    brew install --cask textexpander     # paid, cross-platform

    echo "**** Keepassxc - Keepass port for macOs ****"
    brew install --cask keepassxc
    keepassxc-cli -v

    echo "**** Microsoft Teams ****"
    brew install --cask microsoft-teams

    echo "**** MPV ****"
    brew install --cask mpv

    echo "**** OBS Studio ****"
    brew install --cask obs

    echo "**** PDFs ****"
    brew install --cask adobe-acrobat-reader

    echo "**** Images ****"
    # sudo port install nomacs
    brew install --cask xnviewmp

    echo "**** Window managers ****"
    brew install --cask alt-tab # AltTab - Windows alt-tab on macOS
    brew install --cask rectangle
    brew install --cask amethyst
fi
