#!/bin/bash

# Path to the applications list
APPLICATIONS_FILE="$HOME/files/applications.txt"
XINITRC_FILE="$HOME/.xinitrc"

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

# Install dwm
echo "Installing dwm..."

# Clone the dwm repository
git clone https://git.suckless.org/dwm ~/dwm

# Navigate to the dwm directory and compile dwm
cd ~/dwm
sudo make clean install

echo "dwm installed successfully."

# Create .xinitrc file in the home directory with specific content
echo "Creating .xinitrc file in the home directory..."

cat <<EOL > $XINITRC_FILE
setxkbmap -layout se -variant dvorak &
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &
exec dwm
EOL

echo ".xinitrc file created successfully."

echo "All applications installed successfully."
