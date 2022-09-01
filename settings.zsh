#!/bin/zsh

echo "========================== SYSTEM PREFERENCES ==========================="

echo "**** Scroll direction - Disable “natural” (Lion-style) scrolling ****"
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write -g com.apple.swipescrolldirection -bool FALSE
defaults read -g com.apple.swipescrolldirection

echo "**** Enable LT-US keyboard ****"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleCurrentKeyboardLayoutInputSourceID "org.unknown.keylayout.LithuanianUSkeyboardwithLithuanianletters"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleDefaultAsciiInputSource -dict InputSourceKind "Keyboard Layout" "KeyboardLayout ID" -int 16383 "KeyboardLayout Name" "Lithuanian US keyboard with Lithuanian letters"

defaults delete "~/Library/Preferences/com.apple.HIToolbox" AppleEnabledInputSources

defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleEnabledInputSources -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleInputSourceHistory -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleSelectedInputSources -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"

defaults read ~/Library/Preferences/com.apple.HIToolbox

echo "**** Set language and text formats ****"
# Settings => Language & Region
# defaults write NSGlobalDomain AppleLanguages -array "en-LT" "lt-LT" "ru-LT"
defaults write NSGlobalDomain AppleLanguages -array "en" "lt" "ru"
defaults read NSGlobalDomain AppleLanguages
# defaults write NSGlobalDomain AppleLocale -string "en_GB@currency=EUR"
defaults write NSGlobalDomain AppleLocale -string "en_LT"
defaults read NSGlobalDomain AppleLocale
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults read NSGlobalDomain AppleMeasurementUnits
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults read NSGlobalDomain AppleMetricUnits

echo "======================= FINDER AND DESKTOP =============================="

# echo "**** Allow exiting Fnder  via ⌘ + Q; doing so will also hide desktop icons ****"
# defaults write com.apple.finder QuitMenuItem -bool NO
# defaults write com.apple.finder QuitMenuItem -bool true
defaults read com.apple.finder QuitMenuItem

echo "**** Auto hide menu bar ****"
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults read NSGlobalDomain _HIHideMenuBar
killall Finder

echo "**** Enable Dock autohide ****"
defaults write com.apple.dock autohide -bool true
defaults read com.apple.dock autohide

echo "**** Group windows by application in Mission Control ****"
defaults write com.apple.dock "expose-group-by-app" -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

echo "**** Hot corners ****"
# >> Settings => Mission Control => Hot corners
# Top left screen corner → Quick Note [14]
defaults write com.apple.dock wvous-tl-corner -int 14
# defaults write com.apple.dock wvous-tl-modifier -int 0
defaults read com.apple.dock wvous-tl-corner
# Top right screen corner → Notification Centre [12]
defaults write com.apple.dock wvous-tr-corner -int 12
# defaults write com.apple.dock wvous-tr-modifier -int 0
defaults read com.apple.dock wvous-tr-corner
# Bottom left screen corner → Launchpad [11]
defaults write com.apple.dock wvous-bl-corner -int 11
# defaults write com.apple.dock wvous-bl-modifier -int 0
defaults read com.apple.dock wvous-bl-corner
# defaults read com.apple.dock wvous-bl-modifier
# Bottom right screen corner → Show desktop [4]
defaults write com.apple.dock wvous-bl-corner -int 4
defaults read com.apple.dock wvous-br-corner

echo "**** Animations ****"
# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true
defaults read com.apple.finder | grep DisableAllAnimations

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults read com.apple.dock expose-animation-duration

echo "============================ FILE SYSTEM ================================"

echo "Add symlinks for common folders"
ln -s ~/Dropbox/code ~/code
ln -s ~/Dropbox/dev ~/dev
ln -s ~/Dropbox/soft/mpv_portable/portable_config/* ~/.config/mpv
ln -s $(pwd)/marta ~/Library/Application\ Support/org.yanex.marta
ln -s $(pwd)/espanso ~/Library/Application\ Support/espanso
ln -s ~/dev/config/.aws ~/.aws
ln -s $(pwd)/.hammerspoon ~/.hammerspoon
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.zsh_aliases ~/.zsh_aliases
