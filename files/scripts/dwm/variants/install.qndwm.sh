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

LOCATION="$HOME"
FOLDER="$LOCATION/bash.qndwm"


################################################################### INSTALL DWM-QUERZION
############ INSTALL DWM-QUERZION

#  Download qndwm
git clone https://github.com/querzion/bash.qndwm $LOCATION

#  Make files executable
chmod +x $LOCATION/bash.qndwm/*

#  Go to directory
sh $LOCATION/bash.qndwm/qndwm.sh

rm -R $FOLDER