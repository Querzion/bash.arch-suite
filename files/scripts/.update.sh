#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

###############################

echo -e "${YELLOW} UPDATING PACMAN APPLICATIONS. ${NC}"
sudo pacman -Syyu -y
echo -e "${GREEN} DONE UPDATING. ${NC}"

echo -e "${YELLOW} UPDATING YAY/AUR APPLICATIONS. ${NC}"
sudo yay -Syu -y
echo -e "${GREEN} DONE UPDATING. ${NC}"

echo -e "${YELLOW} UPDATING FLATPAK APPLICATIONS. ${NC}"
flatpak update -y
echo -e "${GREEN} DONE UPDATING. ${NC}"
