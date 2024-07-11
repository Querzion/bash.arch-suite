#!/bin/bash

# Function to get keys and mirrors from ArcoLinux
get_arcolinux_keys_and_mirrors() {
    wget bit.ly/get-arcolinux-keys -O get-arcolinux-keys
    if [ $? -ne 0 ]; then
        echo "Failed to download ArcoLinux keys script"
        exit 1
    fi
    chmod +x ./get-arcolinux-keys
    sudo ./get-arcolinux-keys
    if [ $? -ne 0 ]; then
        echo "Failed to execute ArcoLinux keys script"
        exit 1
    fi
}

# Function to update the system and install archlinux-tweak-tool-git
install_tweak_tool() {
    sudo pacman -Syu archlinux-tweak-tool-git
    if [ $? -ne 0 ]; then
        echo "Failed to install archlinux-tweak-tool-git"
        exit 1
    fi
}

# Main script execution
echo "Getting keys and mirrors from ArcoLinux..."
get_arcolinux_keys_and_mirrors

echo "Keys and mirrors from ArcoLinux have been added to /etc/pacman.conf."

# Check if the user wants to install archlinux-tweak-tool-git
read -p "Do you want to install archlinux-tweak-tool-git? (y/n) " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "Updating system and installing archlinux-tweak-tool-git..."
    install_tweak_tool
    echo "archlinux-tweak-tool-git has been installed."
else
    echo "Skipping the installation of archlinux-tweak-tool-git."
fi

echo "Script execution completed."
