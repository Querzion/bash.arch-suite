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
USER="$HOME"
$INSTALL_DIR="$USER/.config"


# Install ani-cli (Anilist command-line interface)
echo "Installing ani-cli (Anilist command-line interface)..."
git clone https://github.com/erengy/ani-cli $INSTALL_DIR/ani-cli
cd $INSTALL_DIR/ani-cli
sudo make
sudo make install

echo "ani-cli installed successfully."
