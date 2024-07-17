#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

###############################

# Define the shares array in the correct order
shares=("archives" "backups" "downloads" "flash" "isos" "users" "vms")

# Function to create folders if they do not exist
create_folders() {
    local home_folder="$1"

    for share in "${shares[@]}"; do
        if [[ "$share" == "archives" || "$share" == "backups" || "$share" == "downloads" || "$share" == "flash" || "$share" == "isos" || "$share" == "users" || "$share" == "vms" ]]; then
            local folder_path="$home_folder/Network/$share"
        else
            local folder_path="$home_folder/$share"
        fi

        # Check if folder exists
        if [ ! -d "$folder_path" ]; then
            sudo mkdir -p "$folder_path"
            chown $currentUser:$currentUser -R "$mount_point"
            echo -e "${GREEN}Created${NC} $folder_path"
        else
            echo -e "${YELLOW}Folder already exists:${NC} $folder_path"
        fi
    done
}

# Function to mount network shares
mount_shares() {
    local home_folder="/home/$(whoami)"
    local server_ip="$1"
    local username="$2"
    local password="$3"

    for share in "${shares[@]}"; do
        local share_path="//${server_ip}/${share}"
        if [[ "$share" == "archives" || "$share" == "backups" || "$share" == "downloads" || "$share" == "flash" || "$share" == "isos" || "$share" == "users" || "$share" == "vms" ]]; then
            local mount_point="${home_folder}/Network/${share}"
        else
            local mount_point="${home_folder}/${share}"
        fi

        # Check if the mount point exists or create it
        if [ ! -d "$mount_point" ]; then
            sudo mkdir -p "$mount_point"
            chmod -R 0770 "$mount_point"
        fi

        # Mount the share
        sudo mount.cifs "$share_path" "$mount_point" -o username="$username",password="$password"
        echo -e "${PURPLE}Mounted${NC} ${YELLOW}$share_path${NC} to ${GREEN}$mount_point${NC}"
    done
}

# Main script
while true; do
    # Prompt for IP address
    read -p "Enter server IP address: " server_ip

    # Prompt for username
    read -p "Enter username: " username

    # Prompt for password (and hide input)
    read -s -p "Enter password: " password
    echo  # For newline after password input

    # Display entered credentials for confirmation
    echo -e "${YELLOW}Entered credentials:${NC}"
    echo -e "${YELLOW}Server IP:${NC} $server_ip"
    echo -e "${YELLOW}Username:${NC} $username"
    echo -e "${YELLOW}Password:${NC} $password"

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

            # Mount network shares using entered credentials
            mount_shares "$server_ip" "$username" "$password"

            echo -e "${GREEN}Folders and shares mounted successfully.${NC}"
            break  # Exit the loop if credentials are confirmed
            ;;
        [nN])
            echo -e "${YELLOW}Please enter server IP, username, and password again.${NC}"
            ;;
        *)
            echo -e "${RED}Invalid input. Please enter 'y' or 'n'.${NC}"
            ;;
    esac
done

# Further processing or actions with username and password can be added here
