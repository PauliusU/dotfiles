sudo apt update
sudo apt upgrade -y

echo "- locale"
echo "en_US.UTF-8 UTF-8
lt_LT.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
export LC_ALL=en_US
export LANG=en_US
export LANGUAGE=en_US

echo "- Timezone: Vilnius"
sudo timedatectl set-timezone Europe/Vilnius

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
sudo apt install -y rclone # Dropbox, Google Drive and other cloud services
# sudo apt install -y qbittorrent