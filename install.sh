#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

############ FILE & FOLDER PATHS
# CHANGE THE FOLDER NAME & LOCATION IF YOU RENAME THE FOLDER
NAME_FOLDER="$HOME/startup"

# LOCATIONS
CUT="$NAME_FOLDER/files"
PACMAN_APPS="$CUT/pacman-list.txt"
FLATPAC_APPS="$CUT/flatpak-list.txt"
XINITRC_FILE="$HOME/.xinitrc"
BASHRC_FILE="$CUT/configs/.bashrc"
FFCONFIG_FILES="$CUT/configs/.config/fastfetch/"
SCRIPT_FILES="$CUT/scripts/"
DRIVERS="$CUT/scripts/install.video-drivers.sh"
SAMBA="$CUT/samba/"



############ MAKE SCRIPTS EXECUTABLE

chmod +x -R $SCRIPT_FILES

############ UPDATE THE MIRROR LIST
# SETTINGS
COUNTRY="Sweden"

# INSTALL
sudo pacman -S reflector --noconfirm

# CONFIGURE
sudo mv /etc/pacman.d/mirriorlist /etc/pacman.d/mirrorlist.old 
sudo reflector --country $COUNTRY --protocol https --sort rate --save /etc/pacman.d/mirrorlist

############ APPLICATIONS.TXT

# Check if the applications file exists
if [[ ! -f $PACMAN_APPS ]]; then
    echo "The applications file does not exist at $PACMAN_APPS"
    exit 1
fi

# Read the applications list and install each application
while IFS= read -r app; do
    if [[ ! -z "$app" ]]; then
        echo "Installing $app..."
        sudo pacman -S --noconfirm "$app"
    fi
done < "$PACMAN_APPS"


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

############ DWM, SLSTATUS, DMENU, NNN, ST 

sh $SCRIPT_FILES/install.wm-dwm.sh

############ SAMBA

sh $SAMBA/install.samba.sh
echo -e "${GREEN} Samba installed and set up successfully. ${NC}"

############ THUNAR

sh $SCRIPT_FILES/install.thunar.sh
echo -e "${GREEN} Thunar installed and set up successfully. ${NC}"

############ GO BACK

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

echo -e "${GREEN} Flatpak installed and set up successfully. ${NC}"

############ FLATPAK/-S

# Check if the applications file exists
if [[ ! -f $FLATPAK_APPS ]]; then
    echo -e "${RED} The applications file does not exist at $FLATPAK_APPS ${NC}"
    exit 1
fi

# Read the applications list and install each application
while IFS= read -r app; do
    if [[ ! -z "$app" ]]; then
        echo "Installing $app..."
        flatpak install --noconfirm "$app"
        echo -e "${GREEN} $app Installed. ${NC}
    fi
done < "$FLATPAK_APPS"

############ DOCKER

# Start and enable Docker service
echo "Starting Docker service..."
sudo systemctl start docker.service
sudo systemctl enable docker.service

echo -e "${GREEN} Docker installed and configured successfully. ${NC}"

############ INSTALL CHATTERINO

# Check if chatterino2-git is already installed (In case you start the script again.)
if ! pacman -Qi chatterino2-git &> /dev/null; then
    echo "Installing chatterino2-git..."
    yay -S chatterino2-git --noconfirm
    echo "Chatterino Installed."
else
    echo -e "${GREEN} chatterino2-git is already installed. ${NC}"
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

echo -e "${GREEN} .xinitrc file created successfully. ${NC}"

############ .BASHRC

# Create .bashrc file in the home directory with specific content
echo "Creating .bashrc file in the home directory..."

rn ~/.bashrc ~/.bashrc.bak
cp $BASHRC_FILE ~/

echo -e "${GREEN} .bashrc file created successfully. ${NC}"

############ .UPDATE.SH

# Copy and Execute System Update Script
cp $SCRIPT_FILES/.update.sh ~/
chmod +x ~/.update.sh
cd ~/
./update.sh

############ GPU DRIVERS

# Install GPU Drivers
sh $DRIVERS

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
echo -e "${BLUE} Created $CONF_FILE with Swedish Dvorak keyboard configuration. ${NC}"

############ REMOVE STARTUP FOLDER

sudo rm -R $NAME_FOLDER

############ REBOOT MESSAGE
# Optionally, reboot the system to apply changes
echo -e "${RED} | It is recommended to reboot your system to apply the changes .${NC} Do you want to reboot now? (y/n)"
read REBOOT

if [ "$REBOOT" = "y" ]; then
    sudo reboot
fi
