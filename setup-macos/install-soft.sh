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

echo "**** File management and disk usage ****"
# sudo apt install -y mc            # Midnight Commander
brew install midnight-commander
brew install dust # du alternative
brew install ncdu # ncurses du

echo "**** File search ****"
brew install fzf # Fuzzy finder
sudo apt install fzf -y

echo "**** Network ****"
# sudo apt install -y bwm-ng        # bandwidth meter
brew install bwm-ng
brew install bmon

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

    echo "**** File management and file search ****"
    brew install --cask marta # Marta File Manager for macOS. Native. Extensible. Fast. 🚀
    # Marta settings
    ln -sf "$(pwd)/marta" "$HOME/Library/Application Support/org.yanex.marta"
    # Marta terminal integration
    ln -s /Applications/Marta.app/Contents/Resources/launcher /usr/local/bin/marta
    # sudo apt install -y doublecmd-gtk # GUI file manager
    brew install --cask double-commander

    echo "**** File search (everything alternatives) ****"
    brew install --cask easyfind
    # sudo port install recoll # cluncy design
    # fsearch - everything alternative for Linux only

    echo "**** Google Chrome ****"
    brew install --cask google-chrome

    echo "**** Keyboard and automation (shortcuts, text expansion) ****"
    # Better shortcuts with Karabiner Elements and Hammerspoon
    brew install --cask karabiner-elements # Free, open source, mac. Remap the keys on a Mac at the kernel level. Ex KeyRemap4MacBook
    brew install --cask hammerspoon        # Free, open source, mac
    ln -sf "$(pwd)/hammerspoon" "$HOME/.hammerspoon"

    # Espanso. Free, open source, cross-platform text expander
    brew tap espanso/espanso # Add espanso tap, because Espanso is hosted outside the core homebrew repository
    brew install --cask espanso
    espanso path
    # espanso edit # open espanso configuration file in editor
    # espanso install basic-emojis
    espanso package list       # List installed espanso packages
    espanso package update all # Update all packages
    espanso --version
    ln -sf "$(pwd)/espanso" "$HOME/Library/Application Support/espanso"

    # ### macOS built-in automation options ####
    # Script Editor (called AppleScript Editor from 2009 to 2014) for the AppleScript and Javascript
    #       plain text (.applescript), as a compiled script (.scpt), as a script bundle (.scptd), or as an application (.app).
    # Automator # built-in in macOS since 10.4
    # Shortcuts / apple shortcuts / siri shortcuts (formerly Workflow). Syncs with iPhone.

    # Other autmation options
    brew install --cask keyboard-maestro # Paid, mac only
    brew install --cask textexpander     # Paid, cross-platform

    echo "**** keecastr - on-screen keyboard shortcut presenter ****"
    brew install --cask keycastr

    echo "**** Keepassxc - Keepass port for macOS ****"
    brew install --cask keepassxc
    keepassxc-cli -v

    echo "**** Microsoft Teams ****"
    brew install --cask microsoft-teams

    echo "**** Messaging ****"
    brew install --cask slack
    brew install --cask ferdium

    echo "**** MPV ****"
    # sudo apt install -y mpv
    brew install --cask mpv
    mpv --version
    ln -sf "$DOTFILES/mpv" "$HOME/.config/mpv"

    echo "**** OBS Studio ****"
    brew install --cask obs

    echo "**** PDFs ****"
    # brew install --cask adobe-acrobat-reader
    brew install --cask foxitreader

    echo "**** Images ****"
    brew install --cask xnviewmp

    echo "**** Toggl (a.k.a ToggleDesktop) ****"
    brew install --cask toggl-track

    echo "**** Window management ****"
    # brew install --cask alt-tab # AltTab - Windows alt-tab on macOS
    # brew install --cask rectangle
    brew install --cask amethyst
fi
