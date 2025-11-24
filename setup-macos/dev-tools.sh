#!/bin/sh

# Install and setup dev tools

echo "=============================== DEV TOOLS ==============================="

echo "**** AWS tools ****"
brew install awscli
aws --version
ln -nsf ~/Dropbox/dev/config/.aws ~/.aws
ln -nsf ~/Dropbox/dev/config/.aws ~/.config/aws
brew install aws-cdk
cdk --version

echo "**** SSH ****"
ln -nsf ~/Dropbox/dev/config/.ssh ~/.ssh
if [ ! -f ~/.ssh/id_rsa ]; then
    # Generate public/private rsa key pair.
    ssh-keygen -t rsa -C "48020370+PauliusU@users.noreply.github.com"
fi
# Fix 'Permissions for '~/.ssh/id_rsa' are too open' by making read-writable only by you
chmod 600 ~/.ssh/id_rsa
# Test SSH
ssh -T git@github.com

echo "**** GIT ****"
brew install git
mkdir -p "$HOME/.config/git"
touch "$HOME/.config/git/config"
ln -sf "$DOTFILES/.config/git/.gitignore_global" "$HOME/.config/git/ignore"
git config --global user.name "PauliusU"
git config --global user.email "48020370+PauliusU@users.noreply.github.com"
git config --global core.autocrlf input # Line endings for OS compatability. macOS and Linux 'input', Windows 'true'
git config --global core.editor "nvim"
# ln -sf "$(pwd)/.gitignore_global" "$HOME/.gitignore_global"
# git config --global core.excludesfile ~/.gitignore_global
# Git global aliases
# ref: https://dev.to/michaelcurrin/dotfiles-git-config-348o
# More useful branch list -a all branches, -v verbose
git config --global alias.br "branch -a -v"
# Cleaner status output
git config --global alias.st "status -s -b"
# View tags sorted by version number oldest first (use -r for newest first)
git config --global alias.tags "! git tag | sort -V"
# Show git global file and its contents
git config --global --list --show-origin
git --version

echo "**** Git tools ****"
brew install lazygit # Terminal UI for git commands
# Lazygit default path for macOS and Linux now corresponds to XDG base directory spec
ln -nsf "$DOTFILES/.config/lazygit" "$HOME/.config/lazygit"
lazygit --version
brew install git-delta # Better git diff, including word-level diff highlighting
delta --version

echo "**** GitHub CLI ****"
brew install gh
gh --version

echo "**** Neovim / Vim ****"
brew install neovim
ln -nsf "$(pwd)/nvim" "$HOME/.config/nvim"
# Delete local Neovim cache to prevent any issues
rm -rf ~/.local/share/nvim
# Nvim telescope plugin requirements for grep_string and live_grep functions
brew install ripgrep
# scoop install fd
brew install fd
git clone https://github.com/LazyVim/starter ~/.config/nvim-lazyman
git clone https://github.com/NvChad/NvChad ~/.config/nvim-nvchad --depth 1

if [ "$(uname)" = "Linux" ]; then
    # sudo add-apt-repository ppa:neovim-ppa/stable
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
    sudo apt install -y ripgrep
    sudo apt install -y fd-find # Note it's "fd-find" not "fd"
fi

echo "**** Python [Python 3] and artificial intelligence ****"

brew install python                   # Defaults to python3
# Set python symlinks (requires sudo)
ln -sf -- "$BREW_HOME/bin/python3" /usr/local/bin/py
ln -sf -- "$BREW_HOME/bin/python3" /usr/local/bin/python

if [ "$(uname)" = "Linux" ]; then
    sudo apt install -y python3
    sudo apt install -y python-is-python3 # For Debian and Ubuntu
    sudo apt install -y python3-pip
fi

python3 --version
python --version

# Pip
python3 -m pip install --upgrade pip
ln -sf -- "$BREW_HOME/bin/pip3" /usr/local/bin/pip
pip3 --version
pip --version

# Pip global user packages
pip3 install --upgrade --user notebook   # Run using "jupyter notebook"
pip3 install --upgrade --user subliminal # For subs script in MPV

brew install uv
uv --version

echo "**** Redis ****"
brew install redis
redis-cli -v

echo "**** JavaScript, TypeScript, Node.js, NPM, yarn, Volta ****"
mkdir -p "$HOME/.config/npm"
brew install volta
# Volta install on Ubuntu
if [ "$(uname)" = "Linux" ]; then
    curl https://get.volta.sh | bash
fi

volta -v

volta install node@22
# volta pin node@22
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
# Update outdated npm version installed with Node
volta install npm
npm -v
ln -sf ~/Dropbox/dev/config/.npmrc ~/.config/npm/npmrc
npm i -g typescript
tsc -v
npm i -g ts-node
ts-node -v
npm i -g tsx
# Package to update dependency versions in package.json from terminal
npm i -g npm-check-updates
ncu -v
volta list

echo "**** Go Goland ****"
brew install go
go version

echo "**** Rust ****"
brew install rustup
rustup-init
# rustup component add rustfmt
rustup --version
rustup toolchain list
rustc --version
cargo --version
cargo install cargo-watch
cargo install cargo-binstall
env | grep -E 'CARGO_HOME|RUSTUP_HOME'

if [ "$(uname)" = "Darwin" ]; then
    echo "**** Docker ****"
    # Docker desktop
    brew install --cask docker-desktop
    docker version
    docker compose version

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
