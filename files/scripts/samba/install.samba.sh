#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[93m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

currentUser=$(whoami)

SMB="/etc/samba/smb.conf"
SMB_FILES="bash.dwm-arch.startup/files/scripts/samba/conf/"

# Function to install a package
install_package() {
    if ! pacman -Qi $1 &> /dev/null; then
        echo "Installing $1..."
        sudo pacman -S --noconfirm $1
    else
        echo "$1 is already installed."
    fi
}

# Backup the original smb.conf file
if [ ! -f /etc/samba/smb.conf.bak ]; then
    echo "Backing up the original smb.conf file..."
    sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
fi

# Define the path to the smb.conf file
SMB_CONF_PATH="/etc/samba/smb.conf"

echo -e "${GREEN} Creating smb.conf file. ${NC}"

# Write the content to the smb.conf file
cat <<EOL > $SMB_CONF_PATH
[global]
   workgroup = WORKGROUP
   server string = Samba Server
   netbios name = archlinux
   security = user
   map to guest = Bad User
   dns proxy = no

# Most people will want "standalone server" or "member server".
# Running as "active directory domain controller" will require first
# running "samba-tool domain provision" to wipe databases and create a
# new domain.
   server role = standalone server

# this tells Samba to use a separate log file for each machine that connects
   log file = /var/log/samba/%m.log

# Put a capping on the size of the log files (in Kb).
   max log size = 50

[Public]
   path = /srv/samba/public
   browsable = yes
   writable = yes
   guest ok = yes
   read only = no
   public = yes

[SAMBASHARE]
    path = /home/$currentUser/Shared
    browseable = yes
    guest ok = yes
    public = yes
    writable = yes
    read only = no
EOL

echo -e "${GREEN} smb.conf file created at $SMB_CONF_PATH ${NC}"

# Create the shared directory and set permissions
echo -e "${YELLOW} Creating shared directory and setting permissions... ${NC}"
sudo mkdir -p /srv/samba/public
sudo chown -R user:group /srv/samba/public
sudo chmod -R 0775 /srv/samba/public
sudo chown -R user:group /srv/samba/public

# Create the shared directory and set permissions
echo -e "${YELLOW} Creating shared directory and setting permissions... ${NC}"
sudo mkdir -p /home/$currentUser/Shared
sudo chown -R user:group /home/$currentUser/Shared
sudo chmod -R 0775 /home/$currentUser/Shared
sudo chown -R user:group /home/$currentUser/Shared

# Enable & start the Samba services
echo -e "${YELLOW} Enabling and starting Samba services. ${NC}"
sudo systemctl enable smb.service
sudo systemctl start smb.service
sudo systemctl enable nmb.service
sudo systemctl start nmb.service

# Enable & Start the Avahi-daemon service
echo -e "${YELLOW} Configuring Avahi for nework discovery. ${NC}"
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service

# Configure mDNS
echo -e "${YELLOW} Configuring nss-mdns... ${NC}"
sudo sed -i 's/hosts: files mymachines myhostname/hosts: files mymachines myhostname mdns_minimal [NOTFOUND=return] dns/g' /etc/nsswitch.conf

# Install nfs-utils (Uncheck if using script separatly.)
#echo -e "${GREEN} Installing nfs-utils. ${NC}"
#sudo pacman -S nfs-utils

# Enable & Start NFS Server service
sudo systemctl enable nfs-server.service
sudo systemctl start nfs-server.service

# Configure exports
echo -e "${YELLOW} Configuring NFS Exports (/etc/exports) ${NC}"
# Define the NFS export line
NFS_EXPORT_LINE="/srv/nfs 192.168.1.0/24(rw,sync,no_subtree_check)"

# Check if the line already exists in /etc/exports
if ! grep -Fxq "$NFS_EXPORT_LINE" /etc/exports; then
    # Append the line to /etc/exports
    echo "$NFS_EXPORT_LINE" | sudo tee -a /etc/exports
    echo "NFS export configuration added to /etc/exports."
else
    echo "NFS export configuration already exists in /etc/exports."
fi

# Reload the NFS server to apply changes
sudo exportfs -ra
sudo systemctl restart nfs-server

# Install ufw (Uncheck if using script separatly.)
#echo -e "${GREEN} Installing Uncomplicated FireWall. ${NC}"
#sudo pacman -S ufw

# Open necessary ports in the firewall
echo -e "${YELLOW} Configuring UFW (Uncomplicated Firewall) ${NC}"
# NFS Server ports
sudo ufw allow 111/tcp
sudo ufw allow 111/udp
sudo ufw allow 2049/tcp
sudo ufw allow 2049/udp

# Samba ports
sudo ufw allow proto tcp from any to any port 139,445
sudo ufw allow proto udp from any to any port 137,138
sudo ufw allow proto udp from any to any port 5353

# Enable & Start UFW service
sudo ufw enable
sudo systemctl enable ufw.service
sudo systemctl start ufw.service
sudo ufw reload

# Restarting Services
sudo systemctl restart smb.service
sudo systemctl restart nmb.service
sudo systemctl restart avahi-daemon.service
sudo systemctl restart ufw.service
sudo systemctl restart nfs-server.service

# Print status of Samba and Avahi services
echo -e "${YELLOW} Checking status of Samba, Avahi & Ufw.${NC}"
echo "Checking status of Samba and Avahi services..."
sudo systemctl status smb.service
sudo systemctl status nmb.service
sudo systemctl status avahi-daemon.service
sudo systemctl status ufw.service
sudo systemctl status nfs-server.service

echo -e "${RED} If the status is not enabled and active, reboot, and test it again. ${NC}"
echo -e "${GREEN} Setup completed! ${NC} You can now access the shared folder at ${YELLOW} \ \ archlinux.local\Public ${NC}"
echo
