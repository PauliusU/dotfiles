echo =========================== SYSTEM PREFERENCES ============================

echo "**** Scroll direction ****"
defaults write -g com.apple.swipescrolldirection -bool FALSE
defaults read -g com.apple.swipescrolldirection

echo "**** Enable Dock autohide ****"
defaults write com.apple.dock autohide -bool TRUE
defaults read com.apple.dock autohide

echo ============================== FINDER =====================================

# echo "**** Allow to exit finder ****"
# defaults write com.apple.finder QuitMenuItem -bool NO

echo "**** Auto hide menu bar ****"
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults read NSGlobalDomain _HIHideMenuBar
killall Finder