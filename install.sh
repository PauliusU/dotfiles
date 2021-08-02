sudo apt update
sudo apt upgrade

echo --------------------------- SSH setup -------------------------------------
if [[ -f ~/.ssh/id_rsa && -"$HOSTNAME" = "raspberrypi" ]]
then ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1;
else echo "SSH private key exists"
fi
sudo systemctl enable ssh
sudo systemctl start ssh
# sudo service ssh start # start SSH service one time
sudo service ssh status
ssh -T git@github.com # test GitHub SSH

echo -------------------------- Samba server -----------------------------------
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
# Test on Windows with \\<RPi_IP_ADDRESS>\SharePi. E.g.
# \\192.168.0.XXX\SharePi


# ##############################################################################
# PROGRAMMING TOOLS AND RUNTIMES
# ##############################################################################

sudo apt install -y git
# sudo snap install --classic code # VSCode for Ubuntu
sudo apt -y install code # VSCode for Debian 10
sudo apt install -y python-is-python3 # minimum Debian 11 and Ubuntu 20.04

echo ------------------------ NODE.JS AND NVM ----------------------------------
# sudo apt install -y nodejs
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
nvm install node
node -v

# ##############################################################################
# OTHER PROGRAMS
# ##############################################################################
sudo apt install -y rclone # Dropbox, Google Drive and other cloud services
# sudo apt install -y qbittorrent