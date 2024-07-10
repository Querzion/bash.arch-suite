#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[93m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Samba Group Name
sambaShare="qShare" # Replace 'qShare' with your desired group name

# Define directories
currentUser=$(whoami)
sharedDir="/home/$currentUser/Shares/Shared"
publicDir="/srv/samba/Public"

# Function to install a package if not already installed
install_package() {
    pacman -Qi "$1" &> /dev/null || sudo pacman -S --noconfirm "$1"
}

# Function to create a directory if it doesn't exist
create_dir_if_not_exists() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        sudo mkdir -p "$dir" && echo -e "${GREEN}Directory '$dir' created successfully.${NC}" || {
            echo -e "${RED}Error creating directory '$dir'.${NC}"
            exit 1
        }
    else
        echo -e "${YELLOW}Directory '$dir' already exists.${NC}"
    fi
}

# Backup the original smb.conf file
sudo cp -n /etc/samba/smb.conf{,.bak} || true

echo -e "${GREEN} Creating smb.conf file. ${NC}"

# Write the content to the smb.conf file
sudo tee "$SMB" > /dev/null <<EOL
[global]
   workgroup = WORKGROUP
   server string = Samba Server
   netbios name = $(hostname)
   security = user
   map to guest = Bad User
   dns proxy = no
   server role = standalone server
   log file = /var/log/samba/%m.log
   max log size = 50

[Public]
   path = $publicDir
   browsable = yes
   writable = yes
   guest ok = yes
   read only = no
   public = yes

[$sambaShare]
   path = $sharedDir
   browseable = yes
   guest ok = yes
   public = yes
   writable = yes
   read only = no
EOL

testparm

echo -e "${GREEN} smb.conf file created at $SMB ${NC}"

# Create shared directories and set permissions
echo -e "${YELLOW} Creating shared directories and setting permissions... ${NC}"
create_dir_if_not_exists "$publicDir"
sudo chown -R "$currentUser:$sambaShare" "$publicDir"
sudo chmod -R 0775 "$publicDir"

create_dir_if_not_exists "$sharedDir"
sudo chown -R "$currentUser:$sambaShare" "$sharedDir"
sudo chmod -R 0775 "$sharedDir"

# Enable & start Samba and Avahi services
echo -e "${YELLOW} Enabling and starting Samba and Avahi services. ${NC}"
sudo systemctl enable --now smb nmb avahi-daemon

# Configure nss-mdns
echo -e "${YELLOW} Configuring nss-mdns... ${NC}"
sudo sed -i 's/hosts: files mymachines myhostname/hosts: files mymachines myhostname mdns_minimal [NOTFOUND=return] dns/g' /etc/nsswitch.conf

# Install and configure NFS if requested
read -p "Do you want to install and configure NFS? (y/n) " INSTALL_NFS
if [ "$INSTALL_NFS" = "y" ]; then
    install_package "nfs-utils"
    sudo systemctl enable --now nfs-server
    echo "nfs-utils installed and NFS server started."
    # Configure NFS exports
    sudo tee -a /etc/exports > /dev/null <<< "/srv/nfs 192.168.1.0/24(rw,sync,no_subtree_check)"
    sudo exportfs -ra
    sudo systemctl restart nfs-server
    echo "NFS export configuration added and NFS server restarted."
fi

# Configure firewall (UFW)
echo -e "${YELLOW} Configuring UFW (Uncomplicated Firewall)... ${NC}"
sudo pacman -S --noconfirm ufw
sudo ufw allow proto tcp from any to any port 139,445
sudo ufw allow proto udp from any to any port 137,138,5353
sudo ufw --force enable

# Restarting services
echo -e "${YELLOW} Restarting services... ${NC}"
sudo systemctl restart smb nmb avahi-daemon ufw

# Print status of services
echo -e "${YELLOW} Checking status of Samba, Avahi & UFW. ${NC}"
sudo systemctl status smb nmb avahi-daemon ufw

echo -e "${RED} If the status is not enabled and active, reboot and test it again.${NC}"
echo -e "${GREEN} Setup completed! ${NC} You can now access the shared folder at ${YELLOW}\\\\$currentHostname\\Public${NC}"
