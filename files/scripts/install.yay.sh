#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install dependencies for building AUR packages
sudo pacman -S --needed base-devel git

# Install yay
if ! command_exists yay; then
    echo "Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
else
    echo "yay is already installed."
fi

# Clean up temporary files
echo "Cleaning up..."
rm -rf /tmp/yay

echo "Installation of yay is complete."
