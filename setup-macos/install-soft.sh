#!/bin/sh

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

echo "============================ INSTALL SOFT ==============================="

echo "**** 7zip ****"
# p7zip is the command line version of 7-Zip for Linux / Unix, made by an independent developer.
brew install p7zip # Posix 7zip (older version). Acessible using "7z"
7z -version
brew install 7zip # Latest version. Acessible using "7zz"
7zz -version

echo "**** Benchmarks ****"
brew install hyperfine # A command-line benchmarking tool

echo "**** Disk usage ****"
brew install diskonaut # disk usage analyzer and visualiser
brew install dust # du alternative
brew install ncdu # ncurses du

echo "**** File management ****"
brew install midnight-commander
brew install yazi ffmpegthumbnailer sevenzip jq poppler fd ripgrep fzf zoxide imagemagick font-symbols-only-nerd-font
# brew tap homebrew/cask-fonts && brew install --cask font-symbols-only-nerd-font
brew install xdg-ninja # checks your $HOME for unwanted files and directories

echo "**** File search ****"
brew install fzf # Fuzzy finder

echo "**** Media ****"
brew install yt-dlp
brew install ffmpeg
brew install media-info

echo "**** Network monitoring and testing ****"
brew install bwm-ng
brew install bmon
brew tap teamookla/speedtest
brew update
brew install speedtest --force

if [ "$(uname)" = "Darwin" ]; then
    echo "**** Anki ****"
    brew install --cask anki

    # echo "**** DisplayLink Manager - control external displays ****"
    # # Cask was deprecated in 2023-11
    # # brew tap homebrew/cask-drivers
    # brew install --cask displaylink

    echo "**** Battery ****"
    # Battery charge limiter for Apple Silicon Macbook devices
    brew install --cask battery
    # Enable charging when your battery dips under 80, and disable it when it exceeds 80
    battery maintain 80
    battery status
    # Battery info GUI
    brew install --cask coconutbattery

    echo "**** Dropbox sync ****"
    brew install --cask dropbox # official client (takes up device spot)
    # brew install maestral # does not take device spot, but slower sync

    echo "**** Duti - file association manager (macOS only) ****"
    brew install duti
    duti -V # capital V

    echo "**** File management and file search ****"
    # brew install --cask marta # Marta File Manager for macOS. Native. Extensible. Fast. 🚀
    # # Marta settings
    # ln -nsf "$(pwd)/marta" "$HOME/Library/Application Support/org.yanex.marta"
    # # Marta terminal integration
    # ln -s /Applications/Marta.app/Contents/Resources/launcher /usr/local/bin/marta
    brew install --cask double-commander
    ln -nsf "$DOTFILES/Library/Preferences/doublecmd" "$HOME/Library/Preferences/doublecmd"

    # echo "**** File search (everything alternatives) ****"
    # brew install --cask easyfind
    # # sudo port install recoll # cluncy design
    # # fsearch - everything alternative for Linux only

    echo "**** Google Chrome ****"
    brew install --cask google-chrome

    echo "**** Keyboard and automation (shortcuts, text expansion) ****"
    # Better shortcuts with Karabiner Elements and Hammerspoon (for F18 setup)
    brew install --cask karabiner-elements # Free, open source, mac. Remap the keys on a Mac at the kernel level. Ex KeyRemap4MacBook
    ln -nsf "$DOTFILES/.config/karabiner" "$HOME/.config/karabiner"
    brew install --cask hammerspoon        # Free, open source, mac
    defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME"/hammerspoon/init.lua
    ln -nsf "$(pwd)/hammerspoon" "$HOME/.config/hammerspoon"

    # Espanso. Free, open source, cross-platform text expander
    brew install --cask espanso
    espanso path
    # espanso edit # open espanso configuration file in editor
    # espanso install basic-emojis
    espanso package list       # List installed espanso packages
    espanso package update all # Update all packages
    espanso --version
    ln -nsf "$(pwd)/espanso" "$HOME/Library/Application Support/espanso"

    # ### macOS built-in automation options ####
    # Script Editor (called AppleScript Editor from 2009 to 2014) for the AppleScript and Javascript
    #       plain text (.applescript), as a compiled script (.scpt), as a script bundle (.scptd), or as an application (.app).
    # Automator # built-in in macOS since 10.4
    # Shortcuts / apple shortcuts / siri shortcuts (formerly Workflow). Syncs with iPhone.

    echo "**** keecastr - on-screen keyboard shortcut presenter ****"
    brew install --cask keycastr

    echo "**** Keepassxc - Keepass port for macOS ****"
    brew install --cask keepassxc
    keepassxc-cli -v

    echo "**** Messaging ****"
    brew install --cask slack
    brew install --cask ferdium

    echo "**** MPV (using cask for easier file associations) ****"
    # brew install mpv
    brew install --cask stolendata-mpv
    mpv --version
    ln -nsf "$DOTFILES/mpv" "$HOME/.config/mpv"

    echo "**** OBS Studio ****"
    brew install --cask obs

    echo "**** PDFs ****"
    # brew install --cask adobe-acrobat-reader
    brew install --cask foxitreader

    echo "**** Raycast launcher (better Spotlight) ****"
    brew install --cask raycast

    brew install tlrc
    tldr --version # Note: install is 'tlrc' but command is 'tldr'

    echo "**** System info and statistics ****"
    # Stats in the menu bar
    brew install stats
    # System information in terminal
    brew install pfetch-rs

    # echo "**** Window management ****"
    # # brew install --cask alt-tab # AltTab - Windows alt-tab on macOS
    # # brew install --cask rectangle
    # brew install --cask amethyst

fi

if [ "$(uname)" = "Linux" ]; then
    sudo apt install -y bat           # Better cat
    sudo apt install -y btop          # Better top or htop
    sudo apt install -y bwm-ng        # Bandwidth meter
    sudo apt install -y du-dust       # Better du
    sudo apt install -y fish          # Fish shell
    sudo apt install -y fzf           # Fuzzy finder
    sudo apt install -y fd-find       # Better find
    sudo apt install -y git           # Version control
    sudo apt install -y mc            # Midnight Commander
    sudo apt install -y ripgrep       # Better grep
    sudo apt install -y tmux          # Terminal multiplexer
    sudo apt install -y zoxide        # Better cd

    sudo apt install -y doublecmd-gtk # Double Commander - GUI file manager
    sudo apt install -y mpv
fi
