sudo apt update
sudo apt upgrade -y
# sudo apt full-upgrade
# sudo apt-get dist-upgrade
# sudo rpi-update # Update Firmware

# Install ~/dotfiles/crontab as crontab file
# more info: https://kb.iu.edu/d/afiz
crontab ~/dotfiles/crontab

echo "- Locale"
locale
# echo "en_US.UTF-8 UTF-8
# lt_LT.UTF-8 UTF-8" > /etc/locale.gen
sed -i 's|en_GB.UTF-8 UTF-8|\# en_GB.UTF-8 UTF-8|g' /etc/locale.gen
sed -i 's|\# en_US.UTF-8 UTF-8|en_US.UTF-8 UTF-8|g' /etc/locale.gen
sed -i 's|\# lt_LT.UTF-8 UTF-8|lt_LT.UTF-8 UTF-8|g' /etc/locale.gen
sed -i 's|\# ru_RU.UTF-8 UTF-8|ru_RU.UTF-8 UTF-8|g' /etc/locale.gen
# locale-gen
# export LC_ALL=en_US
# export LANG=en_US
# export LANGUAGE=en_US
# export LC_ALL=lt_LT
# export LANG=lt_LT
# export LANGUAGE=lt_LT
locale-gen
locale -a
locale
# update-locale LANG=en_US.UTF-8 UTF-8

echo "- Timezone: Vilnius"
# echo "Europe/Vilnius" > /etc/timezone
sudo timedatectl set-timezone Europe/Vilnius
# Check timezone
sudo dpkg-reconfigure -f noninteractive tzdata

echo "- Keyboard: Lithuanian layout"
echo 'XKBMODEL="pc105"
XKBLAYOUT="lt"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"' > /etc/default/keyboard

echo "- Wi-fi Country"
sudo echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=LT' > /etc/wpa_supplicant/wpa_supplicant.conf


echo "-------------------------- SSH setup ------------------------------------"
if [[ -f ~/.ssh/id_rsa && -"$HOSTNAME" = "raspberrypi" ]]; then 
    echo "Creating new SSH keys"
    ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1;
else 
    echo "SSH private key exists"
fi
if [ "$HOSTNAME" = "raspberrypi" ]; then
    sudo systemctl enable ssh
    sudo systemctl start ssh
    # sudo service ssh start # start SSH service one time
    sudo service ssh status
    ssh -T git@github.com # test GitHub SSH
else
    echo "SSH service skipped"
fi

echo "------------------------- Samba server ----------------------------------"
SHARED_FOLDER="/media/shared"
# SHARED_FOLDER="~/Downloads"
sudo mkdir $SHARED_FOLDER
sudo apt-get install samba
# Give all permissions to the folder
sudo chmod 777 $SHARED_FOLDER
# Change Samba config
# sudo nano /etc/samba/smb.conf
# [SharePi]
# comment = RaspberryPi
# public = yes
# writeable = yes
# browsable = yes
# # path = /media/share
# path = $SHARED_FOLDER
# create mask = 0777
# directory mask = 0777
# Restart Samba to apply changes
sudo service smbd restart
# Create simbolic link (like Windows shortcut) on Desktop
ln -s /media/shared ~/Desktop/shared_files
# Test on Windows with \\<RPi_IP_ADDRESS>\SharePi. E.g.
# \\192.168.0.XXX\SharePi

echo "--------------------- Enable numlock on boot ----------------------------"
# More info: https://www.raspberrypi.org/forums/viewtopic.php?f=91&t=10081&p=250716&sid=3b8f293cee2d5c6f13e5691681fa485f#p250716
sudo apt install -y numlockx
mkdir -p ~/.config/autostart-cron
ln -s ~/dotfiles/.config/autostart-cron/numlock.sh ~/.config/autostart-cron/numlock.sh

echo "------------------------- File system -----------------------------------"
ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases

echo "--------------------------- DNS setup -----------------------------------"
sudo apt install -y resolvconf
# sudo systemctl status resolvconf.service
sudo systemctl start resolvconf.service
sudo systemctl enable resolvconf.service
# sudo systemctl status resolvconf.service
echo "nameserver 8.8.8.8 
nameserver 8.8.4.4" >> /etc/resolvconf/resolv.conf.d/head
# restart the service
sudo systemctl start resolvconf.service
cat /etc/resolv.conf


# ##############################################################################
# PROGRAMMING TOOLS AND RUNTIMES
# ##############################################################################

# sudo snap install --classic code # VSCode for Ubuntu
sudo apt -y install code # VSCode for Debian 10
sudo apt install -y fonts-cascadia-code
sudo apt install -y git
sudo apt install -y vim

echo "------------------------------ PYTHON -----------------------------------"
sudo apt install -y python-is-python3 # minimum Debian 11 and Ubuntu 20.04
sudo apt install -y python3-pip
sudo apt install -y pipenv

echo "----------------------- NODE.JS AND NVM ---------------------------------"
# sudo apt install -y nodejs
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
nvm install node
node -v
npm i -g nodemon
npm i -g yarn

# ##############################################################################
# OTHER PROGRAMS
# ##############################################################################

sudo apt install -y bwm-ng # bandwidth meter
sudo apt install -y cbm # color bandwidth meter
sudo apt install -y doublecmd-gtk # GUI file manager
sudo apt install -y mc # Midnight Commander
sudo apt install -y mpv # media player

echo "----------------------- rclone and Dropbox ------------------------------"
# Based on: https://howchoo.com/pi/how-to-install-dropbox-on-a-raspberry-pi
# sudo apt install -y rclone # Dropbox, Google Drive and other cloud services
# Install latest version of rclone
curl https://rclone.org/install.sh | sudo bash
rclone config # start config to add Dropbox as a "remote"
#   press n - for new remote
#   "dropbox" - for name
#   10 - for Drobpox
#   clien_id > Enter (leave blank)
#   client_secret > Enter (leave blank)
#   advanced config > press "y" if OS has GUI, to simplify token receival
#   "y" to confirm configuration
#   "q" to quit configuration
# Install rclonesync
sudo curl https://raw.githubusercontent.com/cjnaz/rclonesync-V2/master/rclonesync --output /usr/local/bin/rclonesync && sudo chmod +x /usr/local/bin/rclonesync
mkdir ~/.rclonesyncwd
# -p or –parents flag - create the necessary parent directories if they do not exist
mkdir -p ~/dropbox/DropsyncFiles/audiob
rclonesync --first-sync dropbox:/DropsyncFiles/audiob ~/dropbox/DropsyncFiles/audiob
rclonesync --verbose dropbox:/DropsyncFiles/audiob ~/dropbox/DropsyncFiles/audiob
# run rclonesync every 10 minutes
# crontab -e
# */10 * * * * /usr/local/bin/rclonesync dropbox:/DropsyncFiles/audiob ~/dropbox/DropsyncFiles/audiob
crontab -l | { cat; echo "*/10 * * * * /usr/local/bin/rclonesync dropbox:/DropsyncFiles/audiob ~/dropbox/DropsyncFiles/audiob"; } | crontab -

# sudo apt install -y qbittorrent
sudo apt install -y rtorrent
ln -s ~/dotfiles/.rtorrent.rc ~/.rtorrent.rc

echo "--------------------------- remove soft ---------------------------------"
sudo apt remove -y thonny # Python IDE in Raspberry Pi OS