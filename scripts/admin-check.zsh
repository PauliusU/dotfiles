#!/bin/zsh

# Gets information related to admin users

echo "**** Get list of sudoers ****"
sudo cat /etc/sudoers
# As usual, a user can be added to the list of sudoers by adding a line such as this (spaces are optional)
# username ALL=(ALL) ALL
# username ALL = (ALL) ALL

echo "**** Get list of admins ****"
dscl . -read /groups/admin | grep GroupMembership