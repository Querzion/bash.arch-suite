#!/bin/bash

# Function to install using apt
install_with_apt() {
    echo "Detected apt-based distribution."
    echo "Updating package list..."
    sudo apt update
    echo "Installing SimpleScreenRecorder..."
    sudo apt install -y simplescreenrecorder
}

# Function to install using dnf
install_with_dnf() {
    echo "Detected dnf-based distribution."
    echo "Enabling RPM Fusion repository..."
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    echo "Updating package list..."
    sudo dnf update -y
    echo "Installing SimpleScreenRecorder..."
    sudo dnf install -y simplescreenrecorder
}

# Function to install using pacman
install_with_pacman() {
    echo "Detected pacman-based distribution."
    echo "Updating package list..."
    sudo pacman -Syu --noconfirm
    echo "Installing SimpleScreenRecorder..."
    sudo pacman -S --noconfirm simplescreenrecorder
}

# Detect the package manager and install accordingly
if command -v apt &> /dev/null; then
    install_with_apt
elif command -v dnf &> /dev/null; then
    install_with_dnf
elif command -v pacman &> /dev/null; then
    install_with_pacman
else
    echo "Unsupported package manager. Please install SimpleScreenRecorder manually."
    exit 1
fi

echo "SimpleScreenRecorder installation script completed."
