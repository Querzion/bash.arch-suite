#!/bin/bash

# This script downloads a new empty suckless dwm session 

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

############ FILE & FOLDER PATHS
# CHANGE THE FOLDER NAME & LOCATION IF YOU RENAME THE FOLDER
STARTUP="$HOME/bash.dwm-arch.startup"

# LOCATIONS
CUT="$STARTUP/files"
# CONFIGS
CONF_F="$CUT/settings/.config"
# PATCHES
PATCH_F="$CUT/scripts/patch"

PATCH_DWM="$PATCH_F/dwm/install.dwm.patches.sh"
PATCH_ST="$PATCH_F/st/install.st.patches.sh"
PATCH_DMENU="$PATCH_F/dmenu/install.dmenu.patches.sh"
PATCH_SLSTATUS="$PATCH_F/slstatus/install.slstatus.patches.sh"

################################################################### DWM
############ DWM

echo -e "${PURPLE} Installing dwm. ${NC}"

# Install dwm (Dynamic Window Manager)
echo "Installing dwm (Dynamic Window Manager)..."
git clone https://git.suckless.org/dwm ~/.config/dwm
cd ~/.config/dwm
sudo make clean install

echo -e "${GREEN} dwm installed successfully. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
#sudo mv ~/.config/dwm/config.def.h ~/.config/dwm/config.def.h.bak
sudo cp $CONF_F/dwm/config.def.h ~/.config/dwm/config.def.h.new

cd ~/.config/dwm

sudo rm config.h
sudo make clean install

echo -e "${GREEN} dwm is now reconfigured. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read

echo -e "${PURPLE} Patching dwm. ${NC}"

# Patch dwm
sh $PATCH_DWM

echo -e "${GREEN} dwm is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read

################################################################### ST
############ ST

echo -e "${PURPLE} Installing st. ${NC}"

# Install st (suckless terminal)
echo "Installing st (suckless terminal)..."
git clone https://git.suckless.org/st ~/.config/st
cd ~/st
sudo make clean install

echo -e "${GREEN} st installed successfully. ${NC}"

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
#sudo mv ~/.config/st/config.def.h ~/.config/st/config.def.h.bak
sudo cp $CONF_F/st/config.def.h ~/.config/st/config.def.h.new

cd ~/.config/st

sudo rm config.h
sudo make clean install

echo -e "${GREEN} st is now reconfigured. ${NC}"

echo -e "${PURPLE} Patching st. ${NC}"

# Patch st
sh $PATCH_ST

echo -e "${GREEN} st is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### DMENU
############ DMENU

echo -e "${GREEN} Installing dmenu. ${NC}"

# Install dmenu (dynamic menu)
echo "Installing dmenu (dynamic menu)..."
git clone https://git.suckless.org/dmenu ~/.config/dmenu
cd ~/.config/dmenu
sudo make clean install

echo -e "${GREEN} dmenu installed successfully. ${NC}"

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
#sudo mv ~/.config/dmenu/config.def.h ~/.config/dmenu/config.def.h.bak
sudo cp $CONF_F/dmenu/config.def.h ~/.config/dmenu/config.def.h.new

cd ~/.config/dmenu
sudo rm config.h

sudo make clean install

echo -e "${GREEN} dmenu is now reconfigured. ${NC}"

echo -e "${PURPLE} Patching dmenu. ${NC}"

# Patch dmenu
sh $PATCH_DMENU

echo -e "${GREEN} dmenu is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### SLSTATUS
############ SLSTATUS

echo -e "${GREEN} Installing slstatus. ${NC}"

# Install slstatus (taskbar status)
echo "Installing slstatus (Taskbar Status)..."
git clone https://git.suckless.org/slstatus ~/.config/slstatus
cd ~/.config/slstatus
sudo make clean install

echo -e "${GREEN} slstatus installed successfully. ${NC}"

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
#sudo mv ~/.config/slstatus/config.def.h ~/.config/slstatus/config.def.h.bak
sudo cp $CONF_F/slstatus/config.def.h ~/.config/slstatus/config.def.h.new

cd ~/.config/slstatus
sudo rm config.h

sudo make clean install

echo -e "${GREEN} slstatus is now reconfigured. ${NC}"

echo -e "${PURPLE} Patching slstatus. ${NC}"

# Patch slstatus
sh $PATCH_SLSTATUS

echo -e "${GREEN} slstatus is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### NNN
############ NNN

echo -e "${PURPLE} Installing nnn. ${NC}"

# Install nnn (file manager)
echo "Installing nnn (file manager)..."
git clone https://github.com/jarun/nnn ~/.config/nnn
cd ~/.config/nnn
sudo make
sudo make install

echo -e "${GREEN} nnn installed successfully. ${NC}"
