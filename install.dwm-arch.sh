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

# Install st (suckless terminal)
echo "Installing st (suckless terminal)..."
git clone https://git.suckless.org/st ~/st
cd ~/st
sudo make clean install

echo "st installed successfully."

# Install dwm (Dynamic Window Manager)
echo "Installing dwm (Dynamic Window Manager)..."
git clone https://git.suckless.org/dwm ~/dwm
cd ~/dwm
sudo make clean install

echo "dwm installed successfully."

# Install nnn (file manager)
echo "Installing nnn (file manager)..."
git clone https://github.com/jarun/nnn ~/nnn
cd ~/nnn
sudo make
sudo make install

echo "nnn installed successfully."

# Install dmenu (dynamic menu)
echo "Installing dmenu (dynamic menu)..."
git clone https://git.suckless.org/dmenu ~/dmenu
cd ~/dmenu
sudo make clean install

echo "dmenu installed successfully."

# Install ani-cli (Anilist command-line interface)
echo "Installing ani-cli (Anilist command-line interface)..."
git clone https://github.com/erengy/ani-cli ~/ani-cli
cd ~/ani-cli
sudo make
sudo make install

echo "ani-cli installed successfully."

# Go back to the home directory
cd $HOME

# Set up Flatpak
echo "Setting up Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Flatpak installed and set up successfully."

# Install Discord via Flatpak
echo "Installing Discord via Flatpak..."
flatpak install flathub com.discordapp.Discord -y

echo "Discord installed successfully."

# Install OBS Studio via Flatpak
echo "Installing OBS Studio via Flatpak..."
flatpak install flathub com.obsproject.Studio -y

echo "OBS Studio installed successfully."

# Install Brave browser via Flatpak
echo "Installing Brave browser via Flatpak..."
flatpak install flathub org.brave.Browser -y

echo "Brave browser installed successfully."

# Start and enable Docker service
echo "Starting Docker service..."
sudo systemctl start docker.service
sudo systemctl enable docker.service

echo "Docker installed and configured successfully."

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
