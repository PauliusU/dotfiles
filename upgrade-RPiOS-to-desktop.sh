# Upgrade Raspberry Pi OS Lite to Desktop
# [Upgrade Raspbian Lite to Desktop](https://raspberrytips.com/upgrade-raspbian-lite-to-desktop/)
sudo apt install xserver-xorg # display server, the core component of any desktop environment
sudo apt install raspberrypi-ui-mods # PIXEL Desktop
sudo apt install lightdm # the display manager. Used to automatically start the DE on boot and also manage the login part. It’s the link between (OS, Xorg and DE)
sudo apt install chromium-browser