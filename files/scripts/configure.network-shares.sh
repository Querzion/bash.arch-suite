#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Define the shares array in the correct order
shares=("Documents" "Downloads" "Music" "Pictures" "Videos" "Shared" "Archive" "Users" "Backups" "ISOs" "VMs")

# Function to create folders if they do not exist
create_folders() {
    local home_folder="$1"

    for share in "${shares[@]}"; do
        if [[ "$share" == "Shared" || "$share" == "Archive" || "$share" == "Users" || "$share" == "Backups" || "$share" == "ISOs" || "$share" == "VMs" ]]; then
            local folder_path="$home_folder/Shares/$share"
        else
            local folder_path="$home_folder/$share"
        fi

        # Check if folder exists
        if [ ! -d "$folder_path" ]; then
            mkdir -p "$folder_path"
            echo -e "${GREEN}Created${NC} $folder_path"
        else
            echo -e "${YELLOW}Folder already exists:${NC} $folder_path"
        fi
    done
}

# Function to mount network shares
mount_shares() {
    local home_folder="/home/$(whoami)"
    local server_ip="192.168.0.3"
    local username="myuser"
    local password="mypassword"

    for share in "${shares[@]}"; do
        local share_path="//${server_ip}/${share}"
        local mount_point="${home_folder}/Shares/${share}"

        # Check if the mount point exists or create it
        if [ ! -d "$mount_point" ]; then
            mkdir -p "$mount_point"
        fi

        # Mount the share
        sudo mount.cifs "$share_path" "$mount_point" -o username="$username",password="$password"
        echo -e "${GREEN}Mounted${NC} $share_path to $mount_point"
    done
}

# Main script
while true; do
    echo -e "${RED} TIME TO CONFIGURE${NC} ${GREEN}NETWORK SHARES! ${NC}"
    
    # Prompt for username
    read -p " Enter username: " username

    # Prompt for password (and hide input)
    read -s -p " Enter password: " password
    echo  # For newline after password input

    # Display entered credentials for confirmation
    echo -e "${YELLOW} Entered credentials:${NC}"
    echo -e "${YELLOW} Username:${NC} $username"
    echo -e "${YELLOW} Password:${NC} $password"

    # Ask for confirmation
    read -p "Are these credentials correct? (y/n): " confirm

    # Check user confirmation
    case $confirm in
        [yY])
            echo -e "${GREEN}Credentials confirmed.${NC}"

            # Determine the home directory of the currently logged-in user
            current_user=$(whoami)
            home_folder="/home/$current_user"

            # Create necessary folders if they do not exist
            create_folders "$home_folder"

            # Mount network shares
            mount_shares

            echo -e "${GREEN}Folders and shares mounted successfully.${NC}"
            break  # Exit the loop if credentials are confirmed
            ;;
        [nN])
            echo -e "${YELLOW}Please enter username and password again.${NC}"
            ;;
        *)
            echo -e "${RED}Invalid input. Please enter 'y' or 'n'.${NC}"
            ;;
    esac
done

# Further processing or actions with username and password can be added here
