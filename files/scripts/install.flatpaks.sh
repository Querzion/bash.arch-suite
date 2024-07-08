#!/bin/bash

############ DISCORD

# Install Discord via Flatpak
echo "Installing Discord via Flatpak..."
flatpak install discord -y

echo -e "${GREEN} Discord installed successfully. ${NC}"

############ OBS STUDIO

# Install OBS Studio via Flatpak
echo "Installing OBS Studio via Flatpak..."
flatpak install obs-studio -y

echo -e "${GREEN} OBS Studio installed successfully. ${NC}"

############ BRAVE BROWSER

# Install Brave browser via Flatpak
echo "Installing Brave browser via Flatpak..."
flatpak install brave -y

echo -e "${GREEN} Brave browser installed successfully. ${NC}"

############ KEYPASSXC

# Install KeePassXC
echo "Installing KeePassXC..."
flatpak install keepassxc -y

echo -e "${GREEN} KeePassXC installation is complete. ${NC}"

############ Chatterino

# Install Chatterino via Flatpak
echo "Installing Chatterino via Flatpak..."
flatpak install chatterino -y

echo -e "${GREEN} Chatterino installed successfully. ${NC}"
