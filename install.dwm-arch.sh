#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

############ FILE & FOLDER PATHS
# CHANGE THE FOLDER NAME & LOCATION IF YOU RENAME THE FOLDER
NAME_FOLDER="$HOME/bash.dwm-arch.startup"

# LOCATIONS
APPLICATIONS_FILE="$NAME_FOLDER/files/applications.txt"
XINITRC_FILE="$HOME/.xinitrc"
BASHRC_FILE="$NAME_FOLDER/files/configs/.bashrc"
FFCONFIG_FILES="$NAME_FOLDER/files/configs/.config/fastfetch/"
DMCONFIG_FILES="$NAME_FOLDER/files/configs/dmenu/config.def.h"
DWMCONFIG_FILES="$NAME_FOLDER/files/configs/dwn/config.def.h"
STCONFIG_FILES="$NAME_FOLDER/files/configs/st/config.def.h"
SCRIPT_FILES="$NAME_FOLDER/files/scripts/"
DRIVERS="$NAME_FOLDER/files/scripts/install.video-drivers.sh"

############ MAKE SCRIPTS EXECUTABLE

chmod +x -R $SCRIPT_FILES

############ APPLICATIONS.TXT

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


############ ACTIVATE BLUETOOTH

# Enable and start Bluetooth service
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

############ ACTIVATE NETWORK MANAGER

# Enable and start NetworkManager service
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

############ AUR ACCESS

# Install paru.
sh $SCRIPT_FILES/install.paru.sh

# Install yay.
sh $SCRIPT_FILES/install.yay.sh

############ ST

# Install st (suckless terminal)
echo "Installing st (suckless terminal)..."
git clone https://git.suckless.org/st ~/st
cd ~/st
sudo make clean install

echo "${GREEN}st installed successfully.${NC}"

############ DWM

# Install dwm (Dynamic Window Manager)
echo "Installing dwm (Dynamic Window Manager)..."
git clone https://git.suckless.org/dwm ~/dwm
cd ~/dwm
sudo make clean install

echo "${GREEN}dwm installed successfully.${NC}"

############ NNN

# Install nnn (file manager)
echo "Installing nnn (file manager)..."
git clone https://github.com/jarun/nnn ~/nnn
cd ~/nnn
sudo make
sudo make install

echo "${GREEN}nnn installed successfully.${NC}"

############ DMENU

# Install dmenu (dynamic menu)
echo "Installing dmenu (dynamic menu)..."
git clone https://git.suckless.org/dmenu ~/dmenu
cd ~/dmenu
sudo make clean install

echo "${GREEN}dmenu installed successfully.${NC}"

# Go back to the home directory
cd $HOME

############ FASTFETCH CONFIG

# Fix FastFetch Visuals
fastfetch --gen-config-force
mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
cp -R $FFCONFIG_FILES ~/.config/

############ FLATPAK CONFIG

# Set up Flatpak
echo "Setting up Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "${GREEN}Flatpak installed and set up successfully.${NC}"

############ DISCORD

# Install Discord via Flatpak
echo "Installing Discord via Flatpak..."
flatpak install flathub com.discordapp.Discord -y

echo "${GREEN}Discord installed successfully.${NC}"

############ OBS STUDIO

# Install OBS Studio via Flatpak
echo "Installing OBS Studio via Flatpak..."
flatpak install flathub com.obsproject.Studio -y

echo "${GREEN}OBS Studio installed successfully.${NC}"

############ BRAVE BROWSER

# Install Brave browser via Flatpak
echo "Installing Brave browser via Flatpak..."
flatpak install brave -y

echo "${GREEN}Brave browser installed successfully.${NC}"

############ KEYPASSXC

# Install KeePassXC
echo "Installing KeePassXC..."
sudo flatpak install flathub org.keepassxc.KeePassXC -y

echo "${GREEN}KeePassXC installation is complete.${NC}"

############ DOCKER

# Start and enable Docker service
echo "Starting Docker service..."
sudo systemctl start docker.service
sudo systemctl enable docker.service

echo "${GREEN}Docker installed and configured successfully.${NC}"

############ INSTALL CHATTERINO

# Check if chatterino2-git is already installed (In case you start the script again.)
if ! pacman -Qi chatterino2-git &> /dev/null; then
    echo "Installing chatterino2-git..."
    yay -S chatterino2-git --noconfirm
    echo "Chatterino Installed."
else
    echo "${GREEN}chatterino2-git is already installed.${NC}"
fi

############ .XINITRC

# Create .xinitrc file in the home directory with specific content
echo "Creating .xinitrc file in the home directory..."

cat <<EOL > $XINITRC_FILE
#!/bin/sh

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &
exec dwm
EOL

echo "${GREEN}.xinitrc file created successfully.${NC}"

############ .BASHRC

# Create .bashrc file in the home directory with specific content
echo "Creating .bashrc file in the home directory..."

rn ~/.bashrc ~/.bashrc.bak
cp $BASHRC_FILE ~/

echo "${GREEN}.bashrc file created successfully.${NC}"

############ .UPDATE.SH

# Copy and Execute System Update Script
cp $SCRIPT_FILES/.update.sh ~/
chmod +x ~/.update.sh
cd ~/
./update.sh

############ GPU DRIVERS

# Install GPU Drivers
sh DRIVERS

############ SWEDISH DVORAK SETUP

echo "Changing keyboard Layout to Swedish Dvorak."

# Adding Swedish Dvorak to startup
echo '# ' >> ~/.bashrc
echo '# SET KEYBOARD LAYOUT TO SWEDISH DVORAK' >> ~/.bashrc
echo 'setxkbmap -layout se -variant dvorak' >> ~/.bashrc

# Changing KEYMAP to Swedish Dvorak
echo 'KEYMAP=se-dvorak' | sudo tee /etc/vconsole.conf > /dev/null

# Define the file path for the Xorg configuration
CONF_FILE="/etc/X11/xorg.conf.d/10-keyboard.conf"

# Create the directory if it doesn't exist (optional)
sudo mkdir -p "$(dirname "$CONF_FILE")"

# Write the configuration to the file
sudo tee "$CONF_FILE" > /dev/null <<EOF
Section "InputClass"
    Identifier "keyboard-all"
    MatchIsKeyboard "on"
    Option "XkbLayout" "se"
    Option "XkbVariant" "dvorak"
EndSection
EOF

# Inform the user that the file has been created
echo "${BLUE}Created $CONF_FILE with Swedish Dvorak keyboard configuration.${NC}"

############ REMOVE STARTUP FOLDER

sudo rm -R $NAME_FOLDER

############ REBOOT MESSAGE
# Optionally, reboot the system to apply changes
echo "${RED} | It is recommended to reboot your system to apply the changes.${NC} Do you want to reboot now? (y/n)"
read REBOOT

if [ "$REBOOT" = "y" ]; then
    sudo reboot
fi
