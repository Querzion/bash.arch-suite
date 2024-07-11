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

################################################################### FILE & FOLDER PATHS
############ FILE & FOLDER PATHS

# Script Locations
FOLDER="bash.dwm-arch.startup"  # If 'bash.dwm-arch.startup' is renamed in any way.
LOCATION="$HOME/$FOLDER/files/scripts/dwm/dwm-querzion/parts"



################################################################### ST
############ DWM

sh $LOCATION/dwm.sh


################################################################### ST
############ ST

sh $LOCATION/st.sh


################################################################### DMENU
############ DMENU

sh $LOCATION/dmenu.sh


################################################################### SLSTATUS
############ SLSTATUS

sh $LOCATION/slstatus.sh


################################################################### NNN
############ NNN

sh $LOCATION/nnn.sh 
