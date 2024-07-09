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

# Install Paru
if ! command_exists paru; then
    echo -e "${GREEN} Installing PARU. ${NC}"
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
else
    echo -e "${GREEN} PARU is already installed. ${NC}"
fi

# Clean up temporary files
echo "Cleaning up..."
rm -rf /tmp/paru

echo -e "${GREEN} Installation of PARU Complete. ${NC}"
