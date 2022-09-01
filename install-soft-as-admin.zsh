#!/bin/zsh

echo "**** Get list of sudoers ****"
sudo cat /etc/sudoers
# As usual, a user can be added to the list of sudoers by adding a line such as this (spaces are optional)
# username ALL=(ALL) ALL
# username ALL = (ALL) ALL

echo "**** Get list of admins ****"
dscl . -read /groups/admin | grep GroupMembership

echo "**** Anki ****"
brew install --cask anki

echo "**** Keepassxc - Keepass port for macOs ****"
brew install keepassxc
keepassxc-cli -v

echo "**** Microsoft Teams ****"
brew install --cask microsoft-teams

echo "**** PDFs ****"
brew install --cask adobe-acrobat-reader

echo "**** Postman ****"
brew install postman