#!/bin/bash

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

# Copy smb.conf from startup
sudo cp $SMB_FILES/smb.conf.guided $SMB/smb.conf

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
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service

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
