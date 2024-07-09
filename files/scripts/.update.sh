#!/bin/bash

# ANSI color codes

YELLOW='\033[93m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${YELLOW} UPDATING PACMAN APPLICATIONS. ${NC}"
sudo pacman -Syyu -y
echo -e "${GREEN} DONE UPDATING. ${NC}"

echo -e "${YELLOW} UPDATING YAY/AUR APPLICATIONS. ${NC}"
sudo yay -Syu -y
echo -e "${GREEN} DONE UPDATING. ${NC}"

echo -e "${YELLOW} UPDATING FLATPAK APPLICATIONS. ${NC}"
flatpak update -y
echo -e "${GREEN} DONE UPDATING. ${NC}"
