#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if paru or yay is installed
if ! command_exists paru && ! command_exists yay; then
    echo "Neither paru nor yay is installed."
    read -p "Do you want to install paru? (Y/n): " install_paru_choice
    if [[ "$install_paru_choice" == "Y" ]]; then
        chmod +x install.paru.sh
        ./install.paru.sh
    fi

    read -p "Do you want to install yay? (Y/n): " install_yay_choice
    if [[ "$install_yay_choice" == "Y" ]]; then
        chmod +x install.yay.sh
        ./install.yay.sh
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
