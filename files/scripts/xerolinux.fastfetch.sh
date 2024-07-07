#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if paru or yay is installed
if ! command_exists paru && ! command_exists yay; then
    echo "Neither paru nor yay is installed."
    read -p "Do you want to install paru? (yes/no): " install_paru_choice
    if [[ "$install_paru_choice" == "yes" ]]; then
        sudo ./install_paru.sh
    fi

    read -p "Do you want to install yay? (yes/no): " install_yay_choice
    if [[ "$install_yay_choice" == "yes" ]]; then
        sudo ./install_yay.sh
    fi

    if ! command_exists paru && ! command_exists yay; then
        echo "You need to install at least one of paru or yay to continue."
        exit 1
    fi
fi

# Continue with the installation steps if either paru or yay is installed
echo "Proceeding with the installation..."

# Clone the repository
git clone https://github.com/xerolinux/xero-layan-git

# Change directory to the cloned repository
cd xero-layan-git/

# Run the install script
./install.sh
