#!/bin/bash

# This script downloads a fresh empty suckless dwm session if you so want
# but it also extends to adding patches (which can be changed) and my personal
# config.def.h file and possible other files.

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

############################### SETTINGS
USER="$(whoami)"
APP="slstatus"
DESCRIPTON="(Suckless Status Monitor)"
FROM_HERE="https://git.suckless.org/$APP"


################################################################### FILE & FOLDER PATHS
############ FILE & FOLDER PATHS

# Script Locations
FOLDER="bash.dwm-arch.startup"  # If 'bash.dwm-arch.startup' is renamed in any way.
LOCATION="$HOME/$FOLDER/files"

# Patch Script Location
PATCH="$LOCATION/scripts/dwm/dwm-querzion/patch/install.$APP.patches.sh"

# Configuration Files (Edited config.def.h)
CONFIG="$LOCATION/settings/.config/$APP/config.def.h"

# Installation Path
TO_THERE="$HOME/.config/wm/$USER/$APP"

################################################################### BACKUP SETTINGS
############ BACKUP SETTINGS

backup_APP() {

# Source folder
SOURCE_FOLDER="$HOME/.config/wm/$USER/$APP"

# Destination folder
DEST_FOLDER="$HOME/.config/vm"

# Create a timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Zip file name with timestamp
ZIP_FILENAME="$DEST_FOLDER/$USER/$APP-$USER.$TIMESTAMP.zip"

echo -e "${PURPLE} Creating a backup of the prior $APP $DESCRIPTON installation... ${NC}"

# Zip command
zip -r "$ZIP_FILENAME" "$SOURCE_FOLDER"

# Check if the zip command was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Folder '$SOURCE_FOLDER' successfully zipped into '$ZIP_FILENAME'.${NC}"

    # Delete source folder
    rm -rf "$SOURCE_FOLDER"
    echo -e "${GREEN}Source folder '$SOURCE_FOLDER' deleted.${NC}"
else
    echo -e "${RED}Error: Failed to zip the folder.${NC}"
    exit 1
fi
}


################################################################### DWM INSTALL
############ DWM INSTALL

install_APP() {
echo -e "${YELLOW} Creating folder for $APP $DESCRIPTON installation... ${NC}"
# Create folder structure
mkdir -p $HOME/.config/wm
mkdir -p $HOME/.config/wm/$USER

# Prompt about backup
read -p "Do you want to backup prior $APP-$USER install? (y/n): " CHOICE1
if [ "$CHOICE1" = "y" ] || [ "$CHOICE1" = "Y" ]; then
    backup_APP
fi

echo -e "${YELLOW} Getting new $APP $DESCRIPTON source files... ${NC}"

# Install application
git clone $FROM_HERE $TO_THERE && cd $TO_THERE

echo -e "${YELLOW} Compiling $APP $DESCRIPTON... ${NC}"
sudo make clean install

echo -e "${GREEN} $APP installed successfully. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read
}


################################################################### DWM CONFIGURATION
############ DWM CONFIGURATION

configure_APP() {
    echo -e "${PURPLE} Configuring config.def.h file. ${NC}"
    echo "Making a backup."
    # Copy to replace config.def.h
    sudo mv $TO_THERE/config.def.h $TO_THERE/config.def.h.bak
    echo "Copying a new to the directory."
    sudo cp $CONFIG $TO_THERE

    cd $TO_THERE

    sudo rm config.h
    sudo make clean install

    echo -e "${GREEN} $APP is now reconfigured. ${NC}"

    # Pause the script
    #echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
    #read
}

################################################################### DWM PATCHING
############ DWM PATCHING

patch_APP() {
    echo -e "${PURPLE} Patching $APP. ${NC}"

    # Start Patch Install Script
    sh $PATCH

    echo -e "${GREEN} $APP is now patched. ${NC}"

    # Pause the script
    #echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
    #read
}


################################################################### DWM MAIN
############ DWM MAIN

# Lets start the installation
install_APP

# Prompt user to configure application
read -p "Do you want to configure $APP? (y/n): " CHOICE2
if [ "$CHOICE2" = "y" ] || [ "$CHOICE2" = "Y" ]; then
    configure_APP
fi

# Prompt user to patch application
read -p "Do you want to patch $APP? (y/n): " CHOICE3
if [ "$CHOICE3" = "y" ] || [ "$CHOICE3" = "Y" ]; then
    patch_APP
fi

# End of script
echo -e "${GREEN} All tasks completed.${NC}"