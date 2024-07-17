#!/bin/bash

###
###  I created a new repository that has a 'qndwm' install script.
###  This is what is started here. 
###
###

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

################################################################### LOCATION

FOLDER="$HOME/bash.qndwm"


################################################################### INSTALL DWM-QUERZION
############ INSTALL DWM-QUERZION

#  Download qndwm
git clone https://github.com/querzion/bash.qndwm $FOLDER

#  Make files executable
chmod +x -R $FOLDER

#  Go to directory
sh $FOLDER/qndwm.sh

rm -R $FOLDER