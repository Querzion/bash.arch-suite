#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[93m' 
NC='\033[0m' # No Color

############ FILE & FOLDER PATHS
# CHANGE THE FOLDER NAME & LOCATION IF YOU RENAME THE FOLDER
STARTUP="$HOME/bash.dwm-arch.startup"

# LOCATIONS
CUT="$STARTUP/files"
PACMAN_APPS="$CUT/pacman-list.txt"
FLATPAK_APPS="$CUT/flatpak-list.txt"
AUR_APPS="$CUT/aur-list.txt"

XINITRC_FILE="$HOME/.xinitrc"
BASHRC_FILE="$CUT/configs/.bashrc"
#MIRRORLIST="/etc/pacman.d/mirrorlist"
#PACMAN_CONF="/etc/pacman.conf"

NWSHARES="$SCRIPT_FILES/configure.network-shares.sh"

FFCONFIG_FILES="$CUT/configs/.config/fastfetch/"
SCRIPT_FILES="$CUT/scripts"
# GPU Driver Installation path.
DRIVERS="$CUT/scripts/install.video-drivers.sh"
# Samba installation path.
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
    echo -e "${RED} The applications file does not exist at $PACMAN_APPS ${NC}"
    exit 1
fi

# Read the applications list and install each application
while IFS= read -r app; do
    # Skip empty lines and lines starting with #
    if [[ -z "$app" || "$app" == \#* ]]; then
        continue
    fi
        # Check if the application is already installed or not, and acts accordingly.
        if ! pacman -Qi $app &> /dev/null; then
            echo -e "${GREEN} Installing $app from pacman-list.txt. ${NC}"
            sudo pacman -S --noconfirm $app
        else
            echo -e "${YELLOW} $app is already installed. ${NC}"
        fi
done < "$PACMAN_APPS"


################################################################### INSTALL GPU DRIVERS
############ GPU DRIVERS

echo -e "${GREEN} STARTING GPU DRIVER INSTALL. ${NC}"
# Install GPU Drivers
sh $DRIVERS

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### INSTALL & CONFIGURE ROFI
############ INSTALL & CONFIGURE ROFI

echo -e "${GREEN} Starting Rofi Configuration. ${NC}"
sh $SCRIPT_FILES/install.rofi.sh

# Pause the script
echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
read


################################################################### CONFIGURE DOCKER
############ DOCKER

echo -e "${GREEN} Enabling & Starting Docker service. ${NC}"
# Start and enable Docker service
sudo systemctl start docker.service
sudo systemctl enable docker.service

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### ACTIVATE BLUETOOTH
############ ACTIVATE BLUETOOTH

echo -e "${GREEN} Enabling & Starting bluetooth service. ${NC}"
# Enable and start Bluetooth service
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### ACTIVATE NETWORK MANAGER ???
############ ACTIVATE NETWORK MANAGER ???

#echo -e "${GREEN} Enabling & Starting Network Manager service ${NC}"
# Enable and start NetworkManager service
#sudo systemctl enable NetworkManager
#sudo systemctl start NetworkManager

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### INSTALL PARU AND OR YAY | AUR ACCESS
############ INSTALL PARU AND OR YAY | AUR ACCESS

# Install paru.
#sh $SCRIPT_FILES/install.paru.sh

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read

# Install yay.
sh $SCRIPT_FILES/install.yay.sh

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### INSTALL AUR-LIST.TXT (BROKEN ATM)
############ INSTALL AUR-LIST.TXT

## Check if the applications file exists
if [[ ! -f $AUR_APPS ]]; then
    echo -e "${RED} The applications file does not exist at $AUR_APPS ${NC}"
   exit 1
fi

# Read the applications list and install each application
while IFS= read -r app; do
    # Skip empty lines and lines starting with #
    if [[ -z "$app" || "$app" == \#* ]]; then
        continue
    fi
        # Check if the application is already installed or not, and acts accordingly.
        if ! yay -Qi $app &> /dev/null; then
            echo -e "${GREEN} Installing $app from aur-list.txt. ${NC}"
            sudo yay -S --noconfirm $app
        else
            echo -e "${YELLOW} $app is already installed. ${NC}"
        fi
done < "$AUR_APPS"

# Pause the script
echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
read



################################################################### INSTALL WINDOW MANAGER & CONFIGS
############ DWM, SLSTATUS, DMENU, NNN, ST 

sh $SCRIPT_FILES/install.wm-dwm.sh

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### INSTALL SAMBA
############ SAMBA

sh $SAMBA/install.samba.sh
echo -e "${GREEN} Samba installed and set up successfully. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### NETWORK SHARES CONFIGURATION
############ NETWORK SHARES CONFIGURATION

# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)

# Function to prompt the user
network_shares() {
    while true; do
        echo -e "${GREEN} CONFIGURE NETWORK SHARES? ${NC}"
        read -p " (y/n): " yn
        case $yn in
            [Yy]* ) execute_command; break;;
            [Nn]* ) echo "Operation cancelled."; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to execute the command
execute_command() {
    echo -e "${YELLOW} EXECUTING CODE ${NC}"
    
    sh $SCRIPT_FILES/configure.network-shares.sh

    echo -e "${GREEN} DONE. ${NC}"
}

# Call the prompt_user function
network_shares

# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)
# Network Shares (Configure this before executing though!)

# Pause the script
echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
read


################################################################### INSTALL THUNAR
############ THUNAR

# This is now installed through the /files/aur-list.txt
#sh $SCRIPT_FILES/install.thunar.sh
#echo -e "${GREEN} Thunar installed and set up successfully. ${NC}"

############ GO BACK

# Go back to the home directory
cd $HOME


################################################################### CHANGE FASTFETCH LOOKS
############ FASTFETCH CONFIG

echo -e "${GREEN} Fixing Fastfetch visuals. ${NC}"
# Fix FastFetch Visuals
fastfetch --gen-config-force
mv ~/.config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc.bak
cp -R $FFCONFIG_FILES ~/.config/


################################################################### FLATPAK CONFIGURATION
############ FLATPAK CONFIG

# Set up Flatpak
echo -e "${YELLOW} Configuring Flatpak. ${NC}"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "${GREEN} Flatpak is now configured. ${NC}"


################################################################### INSTALL FLATPAK-LIST.TXT
############ FLATPAKS

# Check if the applications file exists
if [[ ! -f $FLATPAK_APPS ]]; then
    echo -e "${RED} The applications file does not exist at $FLATPAK_APPS ${NC}"
    exit 1
fi

while IFS= read -r app; do
    # Skip empty lines and lines starting with #
    if [[ -z "$app" || "$app" == \#* ]]; then
        continue
    fi
         # Check if the application is already installed or not, and acts accordingly.
        if ! flatpak list $app &> /dev/null; then
            echo -e "${GREEN} Installing $app from flatpak-list.txt. ${NC}"
            flatpak install flathub $app -y
                 # Check the exit status of the last command
                if [ $? -ne 0 ]; then
                    echo -e "${RED} Application; $app failed to install. ${NC}"
                else
                    echo -e "${GREEN} $app installed successfully. ${NC}"
                fi
        else
            echo -e "${YELLOW} $app is already installed. ${NC}"
        fi
done < "$FLATPAK_APPS"

echo -e "${GREEN} All flatpak packages have been installed. ${NC}"


################################################################### MANUAL INSTALLATIONS SINCE SOME OF THEM BROKE
############ MANUAL INSTALLS

# Function to ask for installation
ask_install() {
    read -p "$1 (y/n): " choice
    case "$choice" in 
        y|Y ) $2;;
        n|N ) echo "Skipping $1 installation.";;
        * ) echo "Invalid input. Skipping $1 installation.";;
    esac
}

# Chatterino installation
echo -e "${GREEN}CHATTERINO MANUAL INSTALL SINCE AUTO CHOOSES TO ABORT THIS ONE!${NC}"
ask_install "Do you want to install Chatterino?" "flatpak install flathub com.chatterino.chatterino"

# Spotify-adblock installation
echo -e "${GREEN}SPOTIFY-ADBLOCK MANUAL INSTALL SINCE IT DIDN'T WORK!${NC}"
ask_install "Do you want to install Spotify-adblock?" "yay -S spotify-adblock"

echo "Installation script completed."


################################################################### REDOWNLOAD OF BASH.DWM-ARCH.$STARTUP 
############ REDOWNLOAD OF BASH.DWM-ARCH.$STARTUP 

# This is because I have a tendency to change things while I'm doing things.
# It's a development loop. ;P 

# Function to prompt the user
Restart() {
    while true; do
        echo -e "${YELLOW} SCRIPT DEVELOPMENT CYCLE. ${NC}"
        echo -e "${RED} DO YOU WANT TO RESTART THE INSTALLATION PROCESS? ${NC}"
        read -p " (y/n): " yn
        case $yn in
            [Yy]* ) execute_Restart; break;;
            [Nn]* ) echo "SKIPPING DEV LOOP."; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to execute the command
execute_Restart() {
    echo -e "${YELLOW} EXECUTING CODE ${NC}"
    
    sudo rm -R $STARTUP
    cd ~/
    git clone https://github.com/querzion/bash.dwm-arch.startup.git
    chmod +x -R $STARTUP
    sh $STARTUP/install.sh
    
    echo -e "${GREEN} DONE. ${NC}"
}

# Call the prompt_user function
Restart


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

mv ~/.bashrc ~/.bashrc.bak
cp $BASHRC_FILE ~/

echo -e "${GREEN} .bashrc file created successfully. ${NC}"


################################################################### COPY TO HOME AND USE UPDATE SCRIPT
############ .UPDATE.SH

echo -e "${GREEN} Copy update.sh to home folder. ${NC}"

# Copy and Execute System Update Script
cp $SCRIPT_FILES/.update.sh ~/
chmod +x ~/.update.sh

echo -e "${GREEN} Start ./update.sh from home folder. ${NC}"

sh ~/.update.sh


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
############ REMOVE $STARTUP FOLDER

# Delete bash.dwm-arch.startup folder. (If there's updates to be made, then it's not good having an old version.)
sudo rm -R $STARTUP


################################################################### REBOOT MESSAGE
############ REBOOT MESSAGE
# Optionally, reboot the system to apply changes
echo -e "${YELLOW} TIME TO REBOOT! TIME TO REBOOT! TIME TO REBOOT! ${NC}"
echo -e "${RED} It is recommended to reboot your system to apply the changes. ${NC} Do you want to reboot now? (y/n)"
read REBOOT

if [ "$REBOOT" = "y" ]; then
    sudo reboot
fi
