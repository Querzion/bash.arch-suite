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
CUT="$NAME_FOLDER/files"
PACMAN_APPS="$CUT/pacman-list.txt"
FLATPAK_APPS="$CUT/flatpak-list.txt"
AUR_APPS="$CUT/aur-list.txt"

XINITRC_FILE="$HOME/.xinitrc"
BASHRC_FILE="$CUT/configs/.bashrc"
#MIRRORLIST="/etc/pacman.d/mirrorlist"
#PACMAN_CONF="/etc/pacman.conf"

FFCONFIG_FILES="$CUT/configs/.config/fastfetch/"
SCRIPT_FILES="$CUT/scripts/"

DRIVERS="$CUT/scripts/install.video-drivers.sh"
SAMBA="$CUT/samba/"

################################################################### MAKE SCRIPTS EXECUTABLE
############ MAKE SCRIPTS EXECUTABLE

chmod +x -R $SCRIPT_FILES


################################################################### UPDATE MIRROR LIST
############ UPDATE THE MIRROR LIST (Needs some work done before it goes public.)
# SETTINGS
#COUNTRY=Sweden

# INSTALL
#sudo pacman -S reflector --noconfirm

# CONFIGURE
#sudo reflector --country $COUNTRY --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# UPDATE
#pacman -Syyu

################################################################### INSTALL PACMAN-LIST.TXT
############ INSTALL PACMAN-LIST.TXT

# Check if the applications file exists
if [[ ! -f $PACMAN_APPS ]]; then
    echo "The applications file does not exist at $PACMAN_APPS"
    exit 1
fi

# Read the applications list and install each application
while IFS= read -r app; do
    # Skip empty lines and lines starting with #
    if [[ -z "$app" || "$app" == \#* ]]; then
        continue
    fi
        echo -e "${GREEN} Installing $app from pacman-list.txt. ${NC}"
        sudo pacman -S --noconfirm "$app"
done < "$PACMAN_APPS"


################################################################### ACTIVATE BLUETOOTH
############ ACTIVATE BLUETOOTH

# Enable and start Bluetooth service
sudo systemctl enable bluetooth
sudo systemctl start bluetooth


################################################################### ACTIVATE NETWORK MANAGER ???
############ ACTIVATE NETWORK MANAGER ???

# Enable and start NetworkManager service
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager


################################################################### INSTALL PARU & YAY | AUR ACCESS
############ INSTALL PARU & YAY | AUR ACCESS

# Install paru.
sh $SCRIPT_FILES/install.paru.sh

# Install yay.
sh $SCRIPT_FILES/install.yay.sh


################################################################### INSTALL AUR-LIST.TXT (BROKEN ATM)
############ INSTALL AUR-LIST.TXT

## Check if the applications file exists
#if [[ ! -f $AUR_APPS ]]; then
#    echo "The applications file does not exist at $AUR_APPS"
#   exit 1
#fi
#
## Read the applications list and install each application
#while IFS= read -r app; do
#    # Skip empty lines and lines starting with #
#    if [[ -z "$app" || "$app" == \#* ]]; then
#        continue
#    fi
#        echo -e "${GREEN} Installing $app from aur-list.txt. ${NC}"
#        yay -S "$app"
#done < "$AUR_APPS"


################################################################### INSTALL WINDOW MANAGER & CONFIGS
############ DWM, SLSTATUS, DMENU, NNN, ST 

sh $SCRIPT_FILES/install.wm-dwm.sh


################################################################### INSTALL SAMBA
############ SAMBA

sh $SAMBA/install.samba.sh
echo -e "${GREEN} Samba installed and set up successfully. ${NC}"


################################################################### INSTALL THUNAR
############ THUNAR

sh $SCRIPT_FILES/install.thunar.sh
echo -e "${GREEN} Thunar installed and set up successfully. ${NC}"

############ GO BACK

# Go back to the home directory
cd $HOME


################################################################### CHANGE FASTFETCH LOOKS
############ FASTFETCH CONFIG

# Fix FastFetch Visuals
fastfetch --gen-config-force
mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
cp -R $FFCONFIG_FILES ~/.config/


################################################################### FLATPAK CONFIGURATION
############ FLATPAK CONFIG

# Set up Flatpak
echo "Setting up Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "${GREEN} Flatpak installed and set up successfully. ${NC}"


################################################################### INSTALL FLATPAK-LIST.TXT
############ FLATPAKS

# Check if the applications file exists
if [[ ! -f $FLATPAK_APPS ]]; then
    echo "The applications file does not exist at $FLATPAK_APPS"
    exit 1
fi

while IFS= read -r app; do
    # Skip empty lines and lines starting with #
    if [[ -z "$app" || "$app" == \#* ]]; then
        continue
    fi
        echo -e "${GREEN} Installing $app from flatpak-list.txt. ${NC}"
        # Install the flatpak package
        flatpak install flathub "$app" -y

 # Check the exit status of the last command
    if [ $? -ne 0 ]; then
        cho -e "${RED} Application; $app failed to install. ${NC}"
    else
        cho -e "${GREEN} $app installed successfully. ${NC}"
    fi
done < "$FLATPAK_APPS"


echo -e "${GREEN} All flatpak packages have been installed. ${NC}"


################################################################### CONFIGURE DOCKER
############ DOCKER

# Start and enable Docker service
echo "Starting Docker service..."
sudo systemctl start docker.service
sudo systemctl enable docker.service

echo -e "${GREEN} Docker installed and configured successfully. ${NC}"


################################################################### CHANGE .XINITRC
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


################################################################### CHANGE .BASHRC
############ .BASHRC

# Create .bashrc file in the home directory with specific content
echo "Creating .bashrc file in the home directory..."

rn ~/.bashrc ~/.bashrc.bak
cp $BASHRC_FILE ~/

echo -e "${GREEN} .bashrc file created successfully. ${NC}"


################################################################### COPY TO HOME AND USE UPDATE SCRIPT
############ .UPDATE.SH

echo -e "${GREEN} Copy update.sh to home folder. ${NC}"

# Copy and Execute System Update Script
cp $SCRIPT_FILES/.update.sh ~/
chmod +x ~/.update.sh

echo -e "${GREEN} Start ./update.sh from home folder. ${NC}"

cd ~/
./update.sh


################################################################### INSTALL GPU DRIVERS
############ GPU DRIVERS

# Install GPU Drivers
sh $DRIVERS


################################################################### CHANGE KEYBOARD LAYOUT TO SWEDISH DVORAK
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
echo -e "${GREEN} Created $CONF_FILE with Swedish Dvorak keyboard configuration. ${NC}"


################################################################### REMOVE BASH.DWM-ARCH.STARTUP / STARTUP FOLDER
############ REMOVE STARTUP FOLDER

sudo rm -R $NAME_FOLDER


################################################################### MANUAL INSTALLATIONS SINCE SOME OF THEM BROKE
############ MANUAL INSTALLS

echo -e "${GREEN} CHATTERINO MANUAL INSTALL SINCE AUTO CHOOSES TO ABORT THIS ONE! ${NC}"
flatpak install flathub com.chatterino.chatterino

echo -e "${GREEN} SPOTIFY-ADBLOCK MANUAL INSTALL SINCE IT DIDN'T WORK! ${NC}"
yay -S spotify-adblock


################################################################### REBOOT MESSAGE
############ REBOOT MESSAGE
# Optionally, reboot the system to apply changes
echo -e "${RED}    It is recommended to reboot your system to apply the changes .${NC} Do you want to reboot now? (y/n)"
read REBOOT

if [ "$REBOOT" = "y" ]; then
    sudo reboot
fi
