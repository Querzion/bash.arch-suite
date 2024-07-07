#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
NC='\033[0m' # No Color

# LOCATION
DIR="$HOME/bash.dwm-arch.setup/files/scripts/"


# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if paru or yay is installed
if ! command_exists paru && ! command_exists yay; then
    echo "Neither paru nor yay is installed."
    read -p "${RED}Do you want to install paru?${NC} (Y/y to install): " install_paru_choice
    if [[ "$install_paru_choice" == "Y" || "$install_paru_choice" == "y" ]]; then
        chmod +x $DIR/install.paru.sh
        ./$DIR/install.paru.sh
    fi

    read -p "${RED}Do you want to install yay?${NC} (Y/y to install): " install_yay_choice
    if [[ "$install_yay_choice" == "Y" || "$install_yay_choice" == "y" ]]; then
        chmod +x $DIR/install.yay.sh
        ./$DIR/install.yay.sh
    fi

    if ! command_exists paru && ! command_exists yay; then
        echo "You need to install at least one of paru or yay to continue."
        exit 1
    fi
fi
