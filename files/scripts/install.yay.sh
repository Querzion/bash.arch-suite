#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies for building AUR packages
#sudo pacman -S --needed base-devel git

# Install yay
if ! command_exists yay; then
    echo -e "${GREEN} Installing YAY. ${NC}"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
else
    echo -e "${GREEN} YAY is already installed. ${NC}"
fi

# Clean up temporary files
echo "Cleaning up..."
rm -rf /tmp/yay

echo -e "${GREEN} Installation of YAY Complete. ${NC}"
