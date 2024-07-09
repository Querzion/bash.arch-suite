#!/bin/bash

SMB="/etc/samba/smb.conf"

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

# Create a basic smb.conf file
echo "Creating a basic smb.conf file..."
cat <<EOL > $SMB
#======================= Global Settings =====================================
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

# this tells Samba to use a separate log file for each machine
# that connects
   log file = /var/log/samba/%m.log

# Put a capping on the size of the log files (in Kb).
   max log size = 50

#============================ Share Definitions ==============================
[homes]
   comment = Home Directories
   browseable = no
   writable = yes

[Public]
   path = /srv/samba/public
   browsable = yes
   writable = yes
   guest ok = yes
   read only = no
   public = yes

# Change the username - create the SHARED folder
[SAMBASHARE]
    path = /home/querzion/Shared
    browseable = yes
    guest ok = yes
    public = yes
    writable = yes
    read only = no
EOL

# Create the shared directory and set permissions
echo "Creating shared directory and setting permissions..."
sudo mkdir -p /srv/samba/public
sudo chown -R nobody:nogroup /srv/samba/public
sudo chmod -R 0775 /srv/samba/public
sudo chown -R nobody:nogroup /srv/samba/public

# Create the shared directory and set permissions
echo "Creating shared directory and setting permissions..."
sudo mkdir -p /home/querzion/Shared
sudo chown -R nobody:nogroup /home/querzion/Shared
sudo chmod -R 0775 /home/querzion/Shared
sudo chown -R nobody:nogroup /home/querzion/Shared

# Enable and start the Samba services
echo "Enabling and starting Samba services..."
sudo systemctl enable smb.service
sudo systemctl start smb.service
sudo systemctl enable nmb.service
sudo systemctl start nmb.service

# Configure Avahi
echo "Configuring Avahi for network discovery..."
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon

# Configure mDNS
echo "Configuring nss-mdns..."
sudo sed -i 's/hosts: files mymachines myhostname/hosts: files mymachines myhostname mdns_minimal [NOTFOUND=return] dns/g' /etc/nsswitch.conf

# Open necessary ports in the firewall
echo "Configuring UFW (Uncomplicated Firewall)..."
sudo ufw allow proto tcp from any to any port 139,445
sudo ufw allow proto udp from any to any port 137,138
sudo ufw allow proto udp from any to any port 5353
sudo ufw enable
sudo systemctl enable ufw.service
sudo systemctl start ufw.service

# Print status of Samba and Avahi services
echo "Checking status of Samba and Avahi services..."
sudo systemctl status smb
sudo systemctl status nmb
sudo systemctl status avahi-daemon
sudo systemctl status ufw

echo "Setup completed successfully! You can now access the shared folder at \\archlinux.local\Public"
