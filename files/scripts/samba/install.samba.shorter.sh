#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

###############################

# Installation path
CUT="$HOME/bash.dwm-arch.startup/files"

# Log file for package installations
logFile="$HOME/install.samba.shorter.sh_log.txt"
packageFile="$CUT/samba.packages.txt"  # File containing package names

# Define directories
currentUser=$(whoami)


########################################################################## NAME SAMBA GROUP HERE
############ NAME SAMBA GROUP HERE

sambaShare="qShare" # Replace 'qShare' with your desired group name


########################################################################## NAME SHARE FOLDERS HERE
############ NAME SHARE FOLDERS HERE

# This is the names of the FOLDERs that will be created in L
S="qSHARED"        # Change 'qSHARED' into what you want the folder be named.
P="qPUBLIC"        # Change 'qPUBLIC' into what you want the folder be named.
N="qNFS_SHARE"     # Change 'qNFS_SHARE' into what you want the folder be named.


########################################################################## LOCATION
############ LOCATION

# This is a folder in your HOME directory, Rename or keep it as is.
# S, P & N will be folders that are located in this folder.
L="Network"


########################################################################## REFERENCES
############ REFERENCES

# DO NOT CHANGE THESE! 
sCUT="/home/$currentUser"
sharedDir="$sCUT/$L/$S"
publicDir="$sCUT/$L/$P"
nfsExportDir="$sCUT/$L/$N"


########################################################################## FOLDER CREATION
############ FOLDER CREATION

# DO NOT CHANGE THESE!
sudo mkdir -p "$sCUT/$L"
sudo mkdir -p "$sCUT/$L/$S"
sudo mkdir -p "$sCUT/$L/$P"
sudo mkdir -p "$sCUT/$L/$N"

########################################################################## CODE STARTS
############ CODE STARTS

# Setting Computer Hostname
# Check current hostname
currentHostname=$(hostname)
echo -e "Current hostname: ${PURPLE}$currentHostname${NC}"

# Prompt user if they want to change the hostname
read -p "$(echo -e "${GREEN}Do you want to change the hostname?${NC} (y/n): ")" changeHostname

if [[ $changeHostname =~ ^[Yy]$ ]]; then
    # Prompt user for new hostname input
    read -p "$(echo -e "${GREEN}Enter the new hostname:${NC} ")" myRig

    # Update the hostname file
    echo "$myRig" | sudo tee /etc/hostname > /dev/null

    # Update /etc/hosts
    sudo sed -i "s/127.0.0.1.*/127.0.0.1 localhost $myRig/" /etc/hosts

    # Apply the hostname change
    sudo hostnamectl set-hostname "$myRig"

    # Notify user of completion
    echo -e "${GREEN}Hostname set to $myRig.${NC} Please restart your system to apply the changes."
else
    echo "Hostname remains as $currentHostname. No changes made."
fi

# Function to install a package if not already installed and log to file
install_package() {
    local package="$1"
    if pacman -Qi "$package" &> /dev/null; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $package is already installed." >> "$logFile"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Installing $package..." >> "$logFile"
        sudo pacman -S --noconfirm "$package" >> "$logFile" 2>&1
    fi
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
SMB="/etc/samba/smb.conf"

echo -e "${GREEN} Creating smb.conf file.${NC}"

# Write the content to the smb.conf file
sudo tee "$SMB" > /dev/null <<EOL
[global]
   workgroup = WORKGROUP
   server string = Samba Server
   netbios name = $currentHostname
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

# Pause the script
echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
read

# Create shared directories and set permissions
echo -e "${YELLOW} Creating shared directories and setting permissions... ${NC}"
create_dir_if_not_exists "$publicDir"
sudo chown -R "$currentUser:$sambaShare" "$publicDir"
sudo chmod -R 0775 "$publicDir"

create_dir_if_not_exists "$sharedDir"
sudo chown -R "$currentUser:$sambaShare" "$sharedDir"
sudo chmod -R 0775 "$sharedDir"

# Enable & start Samba and Avahi services
echo -e "${YELLOW} Enabling and starting Samba and Avahi services.${NC}"
sudo systemctl enable --now smb nmb avahi-daemon

# Configure nss-mdns
echo -e "${YELLOW} Configuring nss-mdns... ${NC}"
sudo sed -i 's/hosts: files mymachines myhostname/hosts: files mymachines myhostname mdns_minimal [NOTFOUND=return] dns/g' /etc/nsswitch.conf

# Install packages listed in packages.txt
echo -e "${YELLOW} Installing packages from $packageFile... ${NC}"
while IFS= read -r package; do
    install_package "$package"
done < "$packageFile"

# Install and configure NFS
echo -e "${YELLOW} Installing and configuring NFS... ${NC}"
install_package "nfs-utils"

# Configure NFS exports
sudo tee -a /etc/exports > /dev/null <<EOL
$nfsExportDir 192.168.0.0/24(rw,sync,no_subtree_check)
EOL

sudo exportfs -ra  # Reload NFS exports
sudo systemctl enable --now nfs-server  # Restart NFS server

echo -e "${GREEN} NFS export configuration added and NFS server started.${NC}"

# Configure firewall (UFW)
echo -e "${YELLOW} Configuring UFW (Uncomplicated Firewall)... ${NC}"

# SMB ports
sudo ufw allow proto tcp from any to any port 139,445   # SMB/CIFS - File Sharing
sudo ufw allow proto udp from any to any port 137,138,5353   # SMB/CIFS - NetBIOS over TCP/UDP and Bonjour Service Discovery

# NFS ports
sudo ufw allow proto tcp from any to any port 2049   # NFS - TCP
sudo ufw allow proto udp from any to any port 2049   # NFS - UDP
sudo ufw allow proto tcp from any to any port 111    # NFS - TCP
sudo ufw allow proto udp from any to any port 111    # NFS - UDP

sudo ufw --force enable

# Restarting services
echo -e "${YELLOW} Restarting services... ${NC}"
sudo systemctl restart smb nmb avahi-daemon nfs-server

# Pause the script
echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
read

# Print status of services
echo -e "${YELLOW} Checking status of Samba, Avahi, NFS & UFW.${NC}"
sudo systemctl status smb nmb avahi-daemon nfs-server

echo -e "${RED} If the status is not enabled and active, reboot and test it again.${NC}"
echo -e "${GREEN} Setup completed! ${NC} You can now access the shared folder at ${CYAN}\\\\$currentHostname\\Public${NC}"

echo -e "${YELLOW} Installation log saved to: $logFile${NC}"
