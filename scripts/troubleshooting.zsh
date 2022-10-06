#!/bin/zsh

# Toubleshoot system problems by reseting settings and cleaning up the software

# Reset all accesability settings
sudo tccutil reset Accessibility

# Uninstall all apps from macports
sudo port -fp uninstall installed
port installed

if [[ $(uname) == "Linux" ]]; then
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean
    sudo apt-get -y clean
fi
