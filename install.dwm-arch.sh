#!/bin/bash

# Path to the applications list
APPLICATIONS_FILE="~/files/applications.txt"

# Check if the applications file exists
if [[ ! -f $APPLICATIONS_FILE ]]; then
    echo "The applications file does not exist at $APPLICATIONS_FILE"
    exit 1
fi

# Read the applications list and install each application
while IFS= read -r app; do
    if [[ ! -z "$app" ]]; then
        echo "Installing $app..."
        sudo pacman -S --noconfirm "$app"
    fi
done < "$APPLICATIONS_FILE"

echo "All applications installed successfully."
