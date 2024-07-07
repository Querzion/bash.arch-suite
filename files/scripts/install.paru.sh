#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies for building AUR packages
sudo pacman -S --needed base-devel git

# Install paru
if ! command_exists paru; then
    echo "Installing paru..."
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
else
    echo "paru is already installed."
fi

# Clean up temporary files
echo "Cleaning up..."
rm -rf /tmp/paru

echo "Installation of paru is complete."
