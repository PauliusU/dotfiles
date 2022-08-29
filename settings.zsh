#!/bin/zsh

echo "========================== SYSTEM PREFERENCES ==========================="

echo "**** Scroll direction ****"
defaults write -g com.apple.swipescrolldirection -bool FALSE
defaults read -g com.apple.swipescrolldirection

echo "**** Enable Dock autohide ****"
defaults write com.apple.dock autohide -bool TRUE
defaults read com.apple.dock autohide

echo "**** Enable LT-US keyboard ****"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleCurrentKeyboardLayoutInputSourceID "org.unknown.keylayout.LithuanianUSkeyboardwithLithuanianletters"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleDefaultAsciiInputSource -dict InputSourceKind "Keyboard Layout" "KeyboardLayout ID" -int 16383 "KeyboardLayout Name" "Lithuanian US keyboard with Lithuanian letters"

defaults delete "~/Library/Preferences/com.apple.HIToolbox" AppleEnabledInputSources

defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleEnabledInputSources -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleInputSourceHistory -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleSelectedInputSources -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"

defaults read ~/Library/Preferences/com.apple.HIToolbox

echo "============================= FINDER ===================================="

# echo "**** Allow to exit finder ****"
# defaults write com.apple.finder QuitMenuItem -bool NO

echo "**** Auto hide menu bar ****"
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults read NSGlobalDomain _HIHideMenuBar
killall Finder

echo "============================ FILE SYSTEM ================================"

echo "Add symlinks for common folders"
ln -s ~/Dropbox/code ~/code
ln -s ~/Dropbox/dev ~/dev
ln -s ~/Dropbox/soft/mpv_portable/portable_config/* ~/.config/mpv
ln -s $(pwd)/marta ~/Library/Application\ Support/org.yanex.marta
ln -s ~/dev/config/.aws ~/.aws
ln -s $(pwd)/.hammerspoon ~/.hammerspoon
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.zsh_aliases ~/.zsh_aliases
