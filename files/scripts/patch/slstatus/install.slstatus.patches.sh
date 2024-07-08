#!/bin/bash

# Define variables
SLSTATUS_DIR=~/slstatus
PATCHES_DIR=$DMENU_DIR/patches

# Create the patches directory
mkdir -p $PATCHES_DIR
cd $PATCHES_DIR

# Define patch URLs
declare -a patch_urls=(
    # ADD SUCKLESS PATCH LINKS HERE
)

# Download and apply patches
for url in "${patch_urls[@]}"; do
    patch_file=$(basename "$url")
    wget "$url" -O "$patch_file"
    if patch -Np1 -i "$patch_file" -d "$SLSTATUS_DIR"; then
        echo "Applied patch $patch_file successfully."
    else
        echo "Failed to apply patch $patch_file."
        exit 1
    fi
done

# Compile slstatus
cd $SLSTATUS_DIR
if sudo make clean install; then
    echo "slstatus compiled and installed successfully."
else
    echo "Failed to compile and install dwm."
    exit 1
fi

echo "All patches have been downloaded, applied, and slstatus has been installed."
