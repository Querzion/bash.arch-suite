#!/bin/bash

# Update the package database
sudo pacman -Sy

# Detect the GPU
GPU=$(lspci | grep -E "VGA|3D")

# Function to install NVIDIA drivers
install_nvidia_drivers() {
    echo "NVIDIA GPU detected. Installing NVIDIA drivers..."
    sudo pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader
}

# Function to install AMD drivers
install_amd_drivers() {
    echo "AMD GPU detected. Installing AMD drivers..."
    sudo pacman -S --noconfirm xf86-video-amdgpu mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
}

# Function to install Intel drivers (optional, in case the system has integrated Intel graphics)
install_intel_drivers() {
    echo "Intel GPU detected. Installing Intel drivers..."
    sudo pacman -S --noconfirm xf86-video-intel mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
}

# Determine which drivers to install
if echo "$GPU" | grep -i nvidia > /dev/null; then
    install_nvidia_drivers
elif echo "$GPU" | grep -i amd > /dev/null; then
    install_amd_drivers
elif echo "$GPU" | grep -i intel > /dev/null; then
    install_intel_drivers
else
    echo "No supported GPU detected or GPU detection failed."
    exit 1
fi

# Optional: Install additional common packages
sudo pacman -S --noconfirm mesa-utils vulkan-tools

echo "Driver installation completed."


