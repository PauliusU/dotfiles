#!/bin/zsh

# Reset all accesability settings
sudo tccutil reset Accessibility

# Uninstall all apps from macports
sudo port -fp uninstall installed
port installed