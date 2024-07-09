#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
BLUE='\033[93m' #YELLOW!! THE BLUE IS BARELY READABLE
GREEN='\033[0;32m'
NC='\033[0m' # No Color

############ FILE & FOLDER PATHS
# CHANGE THE FOLDER NAME & LOCATION IF YOU RENAME THE FOLDER
NAME_FOLDER="$HOME/bash.dwm-arch.startup"

# LOCATIONS
CUT="$NAME_FOLDER/files"
# CONFIGS
CONF_F="$CUT/configs"

# PATCHES
PATCH_DWM="$CUT/scripts/patch/dwm/install.dwm.patches.sh"
PATCH_ST="$CUT/scripts/patch/st/install.st.patches.sh"
PATCH_DMENU="$CUT/scripts/patch/dmenu/install.dmenu.patches.sh"
PATCH_SLSTATUS="$CUT/scripts/patch/slstatus/install.slstatus.patches.sh"

################################################################### DWM
############ DWM

echo -e "${BLUE} Installing dwm. ${NC}"

# Install dwm (Dynamic Window Manager)
echo "Installing dwm (Dynamic Window Manager)..."
git clone https://git.suckless.org/dwm ~/dwm
cd ~/dwm
sudo make clean install

echo -e "${GREEN} dwm installed successfully. ${NC}"

echo -e "${BLUE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
sudo mv ~/dwm/config.def.h ~/dwm/config.def.h.bak
sudo cp $CONF_F/dwm/config.def.h ~/dwm/config.def.h

cd ~/dwm

sudo rm config.h
sudo make clean install

echo -e "${GREEN} dwm is now reconfigured. ${NC}"

echo -e "${BLUE} Patching dwm. ${NC}"

# Patch dwm
sh $PATCH_DWM

echo -e "${GREEN} dwm is now patched. ${NC}"


################################################################### ST
############ ST

echo -e "${BLUE} Installing st. ${NC}"

# Install st (suckless terminal)
echo "Installing st (suckless terminal)..."
git clone https://git.suckless.org/st ~/st
cd ~/st
sudo make clean install

echo -e "${GREEN} st installed successfully. ${NC}"

echo -e "${BLUE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
sudo mv ~/st/config.def.h ~/st/config.def.h.bak
sudo cp $CONF_F/st/config.def.h ~/st/config.def.h

cd ~/st

sudo rm config.h
sudo make clean install

echo -e "${GREEN} st is now reconfigured. ${NC}"

echo -e "${BLUE} Patching st. ${NC}"

# Patch st
sh $PATCH_ST

echo -e "${GREEN} st is now patched. ${NC}"

################################################################### DMENU
############ DMENU

echo -e "${GREEN} Installing dmenu. ${NC}"

# Install dmenu (dynamic menu)
echo "Installing dmenu (dynamic menu)..."
git clone https://git.suckless.org/dmenu ~/dmenu
cd ~/dmenu
sudo make clean install

echo -e "${GREEN} dmenu installed successfully. ${NC}"

echo -e "${BLUE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
sudo mv ~/dmenu/config.def.h ~/dmenu/config.def.h.bak
sudo cp $CONF_F/dmenu/config.def.h ~/dmenu/config.def.h

cd ~/dmenu
sudo rm config.h

sudo make clean install

echo -e "${GREEN} dmenu is now reconfigured. ${NC}"

echo -e "${BLUE} Patching dmenu. ${NC}"

# Patch dmenu
sh $PATCH_DMENU

echo -e "${GREEN} dmenu is now patched. ${NC}"

################################################################### SLSTATUS
############ SLSTATUS

echo -e "${GREEN} Installing slstatus. ${NC}"

# Install slstatus (taskbar status)
echo "Installing slstatus (Taskbar Status)..."
git clone https://git.suckless.org/slstatus ~/slstatus
cd ~/slstatus
sudo make clean install

echo -e "${GREEN} slstatus installed successfully. ${NC}"

echo -e "${BLUE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
sudo mv ~/slstatus/config.def.h ~/slstatus/config.def.h.bak
sudo cp $CONF_F/slstatus/config.def.h ~/slstatus/config.def.h

cd ~/slstatus
sudo rm config.h

sudo make clean install

echo -e "${GREEN} slstatus is now reconfigured. ${NC}"

echo -e "${BLUE} Patching slstatus. ${NC}"

# Patch slstatus
sh $PATCH_SLSTATUS

echo -e "${GREEN} slstatus is now patched. ${NC}"

################################################################### NNN
############ NNN

echo -e "${BLUE} Installing nnn. ${NC}"

# Install nnn (file manager)
echo "Installing nnn (file manager)..."
git clone https://github.com/jarun/nnn ~/nnn
cd ~/nnn
sudo make
sudo make install

echo -e "${GREEN} nnn installed successfully. ${NC}"
