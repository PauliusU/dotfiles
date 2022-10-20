#!/bin/zsh

# Install software and setup symlinks

echo "=========================== BREW [NON ADMIN] ============================"

if [[ $(command -v brew) == "" ]]; then
    echo "Installing brew"
    mkdir -p ~/bin
    cd ~/bin
    mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    eval "$(homebrew/bin/brew shellenv)"
    brew update --force --quiet
    chmod -R go-w "$(brew --prefix)/share/zsh"
fi
brew --version
brew update  # Update brew itself
brew upgrade # Update packages (installed programs)

echo "=============================== DEV TOOLS ==============================="

echo "**** AWS CLI ****"
brew install awscli
aws --version
ln -sf ~/Dropbox/dev/config/.aws ~/.aws

echo "**** GIT ****"
# sudo apt install -y git
brew install git
git config --global user.name "PauliusU"
git config --global user.email "48020370+PauliusU@users.noreply.github.com"
git config --global core.autocrlf input # Line endings for OS compatability
git config --global core.editor "nvim"
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
git config --global core.editor "nvim"
# Git global aliases
# ref: https://dev.to/michaelcurrin/dotfiles-git-config-348o
# More useful branch list -a all branches, -v verbose
git config --global alias.br "branch -a -v"
# Cleaner status output
git config --global alias.st "status -s -b"
# View tags sorted by version number oldest first (use -r for newest first)
git config --global alias.tags "! git tag | sort -V"
# Show git info
# git config --global --list --show-origin # Show git global file and it's contents
git --version

echo "**** GitHub CLI ****"
brew install gh
gh --version

echo "**** Neovim / Vim ****"
brew install neovim
# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Nvim telescope plugin requirements for grep_string and live_grep functions
brew install ripgrep
# scoop install fd
brew install fd

# sudo apt install -y vim
brew install vim
# Install vim-plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf $(pwd)/nvim ~/.config/nvim
ln -sf $(pwd)/nvim ~/.vim
ln -sf $(pwd)/nvim/init.vim ~/.vimrc

echo "**** Python [Python 3] and artificial intelligence ****"

# sudo apt install -y python3
brew install python                   # Defaults to python3
sudo apt install -y python-is-python3 # Minimum Debian 11 and Ubuntu 20.04
python3 --version
python --version

# Pip
# sudo apt install -y python3-pip
python3 -m pip install --upgrade pip
pip3 --version
pip --version

# Pip global user packages
pip3 install --upgrade --user notebook   # Run using "jupyter notebook"
pip3 install --upgrade --user subliminal # For subs script in MPV

# Pipenv
# sudo apt install -y pipenv
brew install pipenv
pipenv --version

# Conda and Mamba
# scoop install miniconda3
brew install --cask miniforge

# Update conda itself and get info
conda update conda
conda config --show channels
conda --version

# # Clean previous environments (if any)
# conda install anaconda-clean
# Remove all Anaconda-related files and directories without prompt
# anaconda-clean --yes

# Mamba. If conda is already installed, to get mamba, just install it into the base environment from the conda-forge channel:
conda install mamba -n base -c conda-forge
mamba --version

# Create machine learning (ML) environment
mamba create -n ml python=3.8 -y
mamba activate ml
if [[ $(uname) -eq "Darwin" ]]; then
    mamba install -c apple tensorflow-deps -y # The dependencies from Apple to run Tensorflow on arm64, e.g. python, numpy, grpcio and h5py
    pip install tensorflow-metal              # Install tensorflow-metal plugin
    pip install tensorflow-macos              # Install base TensorFlow (it depends upon two packages above)
else
    # View compatible version of tf, cudnn and cudatoolkit in https://www.tensorflow.org/install/source_windows#gpu
    mamba install cudatoolkit=11.2 cudnn=8.1 -c=conda-forge
    pip install --upgrade tensorflow-gpu==2.10.0
    # pip install tensorflow-gpu
    # pip install tensorflow
fi
# Install common Data Science packages
mamba install notebook -y                    # Or use jupyter or jupyterlab
mamba install -c conda-forge matplotlib -y   # For plotting
mamba install -c conda-forge scikit-learn -y # Exposed as sklearn
mamba install -c conda-forge pandas -y       # Data analysis and manipulation
pip install tensorflow-datasets              # Exposed as tf.data.Datasets
pip install --upgrade opencv-python          # Exposed as cv2
pip install --upgrade scikit-image           # Exposed as skimage

# List conda environments
conda env list # = conda info --envs

# micromamba (standalone of Mamba, i.e. no dependency on Conda)
brew install --cask micromamba
micromamba --version
micromamba env
micromamba create -n ml-micromamba jupyter numpy pandas keras matplotlib requests

echo "**** TypeScript, JavaScript, Node.js, NPM, yarn, Volta ****"
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
volta install npm # update oudated version installed with Node
npm -v
npm install --global typescript
tsc -v
npm i -g ts-node
ts-node -v
npm install -g npm-check-updates # Update depenceny versions in package.json from terminal
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
    docker -v                  # = docker --version
    docker version             # More info than docker -v
    docker-compose --version

    echo "**** Git client git-fork ****"
    brew install --cask fork

    echo "**** JetBrains Toolbox ****"
    brew install --cask jetbrains-toolbox

    echo "**** MongoDB compass ****"
    brew install --cask mongodb-compass

    echo "**** Postman ****"
    brew install --cask postman

    echo "**** Visual studio code [VSCode] ****"
    # sudo apt install -y code          # VSCode for Debian 10
    # sudo apt install -y gnome-keyring # required to authorize Visual Studio Code to access GitHub
    # gnome-keyring version
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
# sudo apt install -y mc            # Midnight Commander
brew install midnight-commander

echo "**** Fuzzy finder ****"
brew install fzf

echo "**** Network ****"
# sudo apt install -y bwm-ng        # bandwidth meter
brew install bwm-ng

if [[ $(uname) -eq "Darwin" ]]; then
    echo "**** Anki ****"
    brew install --cask anki

    echo "**** DisplayLink Manager - control external displays ****"
    brew tap homebrew/cask-drivers
    brew install --cask displaylink

    echo "**** Dropbox sync ****"
    brew install --cask dropbox # official client (takes up device spot)
    # brew install maestral # does not take device spot, but slower sync

    echo "**** Duti - file association manager (macOS only) ****"
    brew install duti
    duti -V # capital V

    echo "**** File management ****"
    brew install --cask marta # Marta File Manager for macOS. Native. Extensible. Fast. 🚀
    ln -sf $(pwd)/marta ~/Library/Application\ Support/org.yanex.marta
    # sudo apt install -y doublecmd-gtk # GUI file manager
    brew install --cask double-commander

    echo "**** File search (everything alternatives) ****"
    brew install --cask easyfind
    # sudo port install recoll # cluncy design
    # fsearch - everything alternative for Linux only

    echo "**** Keyboard and automation (shortcuts, text expansion) ****"
    # Better shortcuts with Karabiner Elements and Hammerspoon
    brew install --cask karabiner-elements # Free, open source, mac. Remap the keys on a Mac at the kernel level. Ex KeyRemap4MacBook
    brew install --cask hammerspoon        # Free, open source, mac
    ln -sf $(pwd)/hammerspoon ~/.hammerspoon

    # Espanso. Free, open source, cross-platform
    brew tap espanso/espanso # Add espanso tap, because Espanso is hosted outside the core homebrew repository
    brew install --cask espanso
    espanso path
    # espanso edit # open espanso configuration file in editor
    # espanso install basic-emojis
    espanso package list       # List installed espanso packages
    espanso package update all # Update all packages
    espanso --version
    ln -sf $(pwd)/espanso ~/Library/Application\ Support/espanso

    # ### macOS built-in options ####
    # Script Editor (called AppleScript Editor from 2009 to 2014) for the AppleScript and Javascript
    #       plain text (.applescript), as a compiled script (.scpt), as a script bundle (.scptd), or as an application (.app).
    # Automator # built-in in macOS since 10.4
    # Shortcuts / apple shortcuts / siri shortcuts (formerly Workflow). Syncs with iPhone.

    # Other autmation options
    brew install --cask keyboard-maestro # Paid, mac only
    brew install --cask textexpander     # Paid, cross-platform

    echo "**** Keepassxc - Keepass port for macOS ****"
    brew install --cask keepassxc
    keepassxc-cli -v

    echo "**** Microsoft Teams ****"
    brew install --cask microsoft-teams

    echo "**** MPV ****"
    # sudo apt install -y mpv
    brew install --cask mpv
    mpv --version
    ln -sf ~/Dropbox/soft/mpv_portable/portable_config/* ~/.config/mpv

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
