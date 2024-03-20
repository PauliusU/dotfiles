#!/bin/sh

# Install and setup dev tools

echo "=============================== DEV TOOLS ==============================="

echo "**** AWS CLI ****"
brew install awscli
aws --version
ln -sf ~/Dropbox/dev/config/.aws ~/.aws

echo "**** SSH ****"
ln -sf ~/Dropbox/dev/config/.ssh ~/.ssh
if [ ! -f ~/.ssh/id_rsa ]; then
    # Generate public/private rsa key pair.
    ssh-keygen -t rsa -C "48020370+PauliusU@users.noreply.github.com"
fi
# Test SSH
ssh -T git@github.com
ssh -T git@gitlab.mellifera.team

echo "**** GIT ****"
# sudo apt install -y git
brew install git
mkdir -p "$HOME/.config/git"
ln -sf "$DOTFILES/.gitignore_global" "$HOME/.config/git/ignore"
git config --global user.name "PauliusU"
git config --global user.email "48020370+PauliusU@users.noreply.github.com"
git config --global core.autocrlf input # Line endings for OS compatability. macOS and Linux 'input', Windows 'true'
git config --global core.editor "nvim"
# ln -sf "$(pwd)/.gitignore_global" "$HOME/.gitignore_global"
# git config --global core.excludesfile ~/.gitignore_global
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

echo "**** Git tools ****"
brew install lazygit # Terminal UI for git commands
ln -sf "$DOTFILES/terminal/lazygit" "$HOME/Library/Application Support/lazygit"
lazygit --version
brew install git-delta # Better git diff, including word-level diff highlighting
delta --version

echo "**** GitHub CLI ****"
brew install gh
gh --version

echo "**** Neovim / Vim ****"
brew install neovim
ln -sf "$(pwd)/nvim" "$HOME/.config/nvim"
# Delete local Neovim cache to prevent any issues
rm -rf ~/.local/share/nvim
# Nvim telescope plugin requirements for grep_string and live_grep functions
brew install ripgrep
# scoop install fd
brew install fd
git clone https://github.com/LazyVim/starter ~/.config/nvim-lazyman
git clone https://github.com/NvChad/NvChad ~/.config/nvim-nvchad --depth 1

# sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim
sudo apt install -y ripgrep
sudo apt install -y fd-find # Note it's "fd-find" not "fd"
# tsserver requires npm

echo "**** Python [Python 3] and artificial intelligence ****"

# sudo apt install -y python3
brew install python                   # Defaults to python3
# sudo apt install -y python-is-python3 # For Debian and Ubuntu
brew unlink python@3.12 && brew link python@3.12
# Set python symlinks (requires sudo)
# ln -sf -- $BREW_HOME/bin/python3.12(:P) /usr/local/bin/py
ln -sf -- $BREW_HOME/bin/python3.12(:P) /usr/local/bin/python
ln -sf -- "$(readlink -f $BREW_HOME/bin/python3.12)" /usr/local/bin/python3

python3 --version
python --version

# Pip
# sudo apt install -y python3-pip
python3 -m pip install --upgrade pip
ln -sf -- $BREW_HOME/bin/pip3.12(:P) /usr/local/bin/pip
ln -sf -- $BREW_HOME/bin/pip3.12(:P) /usr/local/bin/pip3
pip3 --version
pip --version

# Pip global user packages
pip3 install --upgrade --user notebook   # Run using "jupyter notebook"
pip3 install --upgrade --user subliminal # For subs script in MPV

# # Poetry
# brew install poetry
# poetry --version
# poetry config virtualenvs.path $HOME/.cache/pypoetry/virtualenvs
# poetry config virtualenvs.path

# # Pipenv
# # sudo apt install -y pipenv
# brew install pipenv
# pipenv --version

# # Conda and Mamba
# # scoop install miniconda3
# brew install --cask miniforge

# # Update conda itself and get info
# conda update conda
# conda config --show channels
# conda --version

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

echo "**** Redis ****"
brew install redis
redis-cli -v

echo "**** JavaScript, TypeScript, Node.js, NPM, yarn, Volta ****"
brew install volta
# curl https://get.volta.sh | bash
volta -v

volta install node@18
# volta pin node@18
# volta uninstall node is not supported. Remove node version from ~/.volta/tools/image/node/ instead
volta list node
volta which node
node -v
volta install pnpm
pnpm -v
# pnpm config set store-dir $HOME/.cache/.pnpm-store
pnpm store path
volta install bun
bun --version
volta install npm # update oudated npm version installed with Node
npm -v
ln -sf ~/Dropbox/dev/config/.npmrc ~/.npmrc
npm i -g typescript
npm i -g ts-node
npm i -g npm-check-updates # Update depenceny versions in package.json from terminal
tsc -v
ts-node -v
ncu -v
volta list

echo "**** Go Goland ****"
brew install go
go version

echo "**** Rust ****"
brew install rustup
# rustup component add rustfmt
rustup --version
rustup toolchain list
rustc --version
cargo --version
cargo install cargo-watch

if [[ $(uname) -eq "Darwin" ]]; then
    echo "**** Docker ****"
    brew install --cask docker # Docker desktop
    docker -v                  # = docker --version
    docker version             # More info than docker -v
    docker compose version     # = docker-compose --version

    echo "**** Act - run GitHub Actions locally ****"
    brew install act
    act --version

    echo "**** Git client git-fork ****"
    brew install --cask fork

    echo "**** JetBrains Toolbox ****"
    brew install --cask jetbrains-toolbox

    echo "**** Postman ****"
    brew install --cask postman

    echo "**** Visual studio code [VSCode] ****"
    # sudo apt install -y code
    # sudo apt install -y gnome-keyring # required to authorize Visual Studio Code to access GitHub
    # gnome-keyring version
    brew install --cask visual-studio-code
    code -v

    echo "**** xcode ****"
    /usr/bin/xcodebuild -version
    clang --version
    # xcode-select --install # install mac build tools
    xcode-select --version

    echo "=========================== Database tools =========================="

    echo "**** MongoDB compass ****"
    brew install --cask mongodb-compass

    echo "**** PostgreSQL psql ****"
    brew install libpq # installs psql, a terminal-based front-end to PostgreSQL
    brew link --force libpq
    psql --version
    # pgAdming # GUI client for PostgreSQL

    echo "**** TablePlus - GUI client for PostgreSQL, SQLite, MongoDB ****"
    brew install --cask tableplus
fi
