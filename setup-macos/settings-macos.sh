#!/bin/sh
# macOS system settings

# General => Language & Region
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

echo "**** Reduce animations ****"
# Accessibility => Display => Reduce motion => on
defaults write com.apple.universalaccess reduceMotion -bool true
defaults read com.apple.universalaccess reduceMotion
defaults write com.apple.dock autohide-time-modifier -float 0.15; killall Dock

# Desktop & Dock => Dock
echo "**** Enable Dock autohide ****"
defaults write com.apple.dock autohide -bool true
defaults read com.apple.dock autohide

# Desktop & Dock => Menu Bar
echo "**** Auto hide menu bar ****"
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults read NSGlobalDomain _HIHideMenuBar
killall Finder

# Desktop & Dock => Mission control
echo "**** Group windows by application in Mission Control ****"
defaults write com.apple.dock "expose-group-by-app" -bool true

echo "Disable 'Displays have separate Spaces' [Requires log out]"
defaults write com.apple.spaces spans-displays -int 1
defaults read com.apple.spaces spans-displays

# Desktop & Dock => Hot corners
echo "**** Hot corners ****"
# => Settings => Mission Control => Hot corners
# Possible values:
#     0: no-op
#     2: Mission Control
#     3: Show application windows
#     4: Desktop
#     5: Start screen saver
#     6: Disable screen saver
#     7: Dashboard
#    10: Put display to sleep
#    11: Launchpad
#    12: Notification Center
#    14: Quick Note
# Top left screen corner → Quick Note [14]
defaults write com.apple.dock wvous-tl-corner -int 14
# Top right screen corner → Notification Centre [12]
defaults write com.apple.dock wvous-tr-corner -int 12
# Bottom left screen corner → Launchpad [11]
defaults write com.apple.dock wvous-bl-corner -int 11
# Bottom right screen corner → Show desktop [4]
defaults write com.apple.dock wvous-bl-corner -int 4
defaults read com.apple.dock | grep wvous

# Desktop & Dock => options inaccesible in the UI
echo "**** Allow exiting Finder via ⌘ + Q; doing so will also hide desktop icons ****"
# defaults write com.apple.finder QuitMenuItem -bool true
defaults read com.apple.finder QuitMenuItem
# defaults write com.apple.finder QuitMenuItem -bool NO # Default value

echo "**** Show the ~/Library folder ****"
chflags nohidden ~/Library

echo "**** Reduce animations ****"
# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true
defaults read com.apple.finder | grep DisableAllAnimations

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults read com.apple.dock expose-animation-duration

echo "***** Hide single external drive from desktop ****"
sudo chflags hidden /Volumes/SSD4
killall Finder
# # Unhide
# sudo chflags nohidden /Volumes/SSD4

# Keyboard => Text input
echo "**** Enable LT-US keyboard ****"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleCurrentKeyboardLayoutInputSourceID "org.unknown.keylayout.LithuanianUSkeyboardwithLithuanianletters"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleDefaultAsciiInputSource -dict InputSourceKind "Keyboard Layout" "KeyboardLayout ID" -int 16383 "KeyboardLayout Name" "Lithuanian US keyboard with Lithuanian letters"

defaults delete "~/Library/Preferences/com.apple.HIToolbox" AppleEnabledInputSources

defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleEnabledInputSources -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleInputSourceHistory -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"
defaults write "~/Library/Preferences/com.apple.HIToolbox" AppleSelectedInputSources -array "{ InputSourceKind = \"Keyboard Layout\"; \"KeyboardLayout ID\" = 16383; \"KeyboardLayout Name\" = \"Lithuanian US keyboard with Lithuanian letters\"; }"

defaults read ~/Library/Preferences/com.apple.HIToolbox

# Trackpad => Scroll & Zoom => Natural scolling
echo "**** Scroll direction - Disable “natural” (Lion-style) scrolling ****"
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write -g com.apple.swipescrolldirection -bool FALSE
defaults read -g com.apple.swipescrolldirection

echo "🏖️🛝 Sandbox (test before including in the main configuration)"
echo "**** Dark mode: System Preferences -> General -> Appearance -> Dark ****"
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
# defaults write NSGlobalDomain AppleInterfaceStyle Dark  # Use dark menu bar and dock.
# defaults read -g NSGlobalDomain AppleInterfaceStyle

