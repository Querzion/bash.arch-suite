#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print messages
print_message() {
    color=$1
    message=$2
    echo -e "${color}${message}${NC}"
}

# Define variables
USER="$(whoami)"
APP="dwm"
APP_DIR="$HOME/.config/wm/$USER/$APP
PATCHES_DIR=$APP_DIR/patches

# Create the patches directory
mkdir -p $PATCHES_DIR
print_message $CYAN "Created patches directory at $PATCHES_DIR"
cd $PATCHES_DIR

# Define patch URLs
declare -a patch_urls=(
    "https://dwm.suckless.org/patches/status2d/dwm-status2d-6.2.diff"
    "https://dwm.suckless.org/patches/dwmblocks/dwmblocks.diff"
    "https://dwm.suckless.org/patches/bstack/dwm-bstack-6.2.diff"
    "https://dwm.suckless.org/patches/centeredmaster/dwm-centeredmaster-6.2.diff"
    "https://dwm.suckless.org/patches/deck/dwm-deck-6.2.diff"
    "https://dwm.suckless.org/patches/alwayscenter/dwm-alwayscenter-6.2.diff"
    "https://dwm.suckless.org/patches/pertag/dwm-pertag-6.2.diff"
    "https://dwm.suckless.org/patches/systray/dwm-systray-6.2.diff"
    "https://dwm.suckless.org/patches/fullscreen/dwm-fullscreen-6.2.diff"
    "https://dwm.suckless.org/patches/push/dwm-push-6.2.diff"
    "https://dwm.suckless.org/patches/swallow/dwm-swallow-6.2.diff"
    "https://dwm.suckless.org/patches/alpha/dwm-alpha-6.2.diff"
    "https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.2.diff"
    "https://dwm.suckless.org/patches/hide_xresources/dwm-hide_xresources-6.2.diff"
    "https://dwm.suckless.org/patches/focusonclick/dwm-focusonclick-6.2.diff"
    "https://dwm.suckless.org/patches/warp/dwm-warp-6.2.diff"
    "https://dwm.suckless.org/patches/dualstatus/dwm-dualstatus-6.2.diff"
    "https://dwm.suckless.org/patches/fakefullscreen/dwm-fakefullscreen-6.2.diff"
    "https://dwm.suckless.org/patches/autostart/dwm-autostart-6.2.diff"
    "https://dwm.suckless.org/patches/scratchpads/dwm-scratchpads-6.2.diff"
)

# Download and apply patches
for url in "${patch_urls[@]}"; do
    patch_file=$(basename "$url")
    print_message $CYAN "Downloading patch from $url"
    wget "$url" -O "$patch_file"
    if patch -Np1 -i "$patch_file" -d "$APP_DIR"; then
        print_message $GREEN "Applied patch $patch_file successfully."
    else
        print_message $RED "Failed to apply patch $patch_file."
        exit 1
    fi
done

# Compile $APP
cd $APP_DIR
if sudo make clean install; then
    print_message $GREEN "$APP compiled and installed successfully."
else
    print_message $RED "Failed to compile and install $APP."
    exit 1
fi

print_message $CYAN "All patches have been downloaded, applied, and $APP has been installed."


