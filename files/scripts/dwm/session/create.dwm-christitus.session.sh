#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Define variables
USER_HOME="$HOME"
DWM_CONFIG_DIR="$USER_HOME/.config/dwm/ctt"
DWM_START_SCRIPT="$DWM_CONFIG_DIR/dwm-start.sh"
DWM_DESKTOP_FILE="/usr/share/xsessions/dwm-ctt.desktop"

# Function to print messages
print_message() {
    color=$1
    message=$2
    echo -e "${color}${message}${NC}"
}

print_message $CYAN "Starting DWM session setup..."

# Create DWM configuration directory if it doesn't exist
mkdir -p "$DWM_CONFIG_DIR"
print_message $GREEN "Created DWM configuration directory at $DWM_CONFIG_DIR"

# Create the DWM start script
cat << 'EOF' > "$DWM_START_SCRIPT"
#!/bin/bash

# Start dwm
exec /home/yourusername/.config/dwm/ctt
EOF
print_message $GREEN "Created DWM start script at $DWM_START_SCRIPT"

# Replace 'yourusername' with the actual username
sed -i "s|yourusername|$(whoami)|g" "$DWM_START_SCRIPT"
print_message $GREEN "Replaced placeholder username with actual username in $DWM_START_SCRIPT"

# Make the DWM start script executable
chmod +x "$DWM_START_SCRIPT"
print_message $GREEN "Made DWM start script executable"

# Create the DWM desktop entry file
sudo bash -c "cat << 'EOF' > $DWM_DESKTOP_FILE
[Desktop Entry]
Name=DWM - CTT
Comment=Dynamic Window Manager
Exec=$DWM_START_SCRIPT
Icon=dwm
Type=Application
EOF"
print_message $GREEN "Created DWM desktop entry file at $DWM_DESKTOP_FILE"

print_message $CYAN "DWM session setup is complete. Please log out and select the DWM session to start."

# Verify DWM installation
if [ -f "$DWM_CONFIG_DIR/dwm/ctt" ]; then
    print_message $GREEN "DWM binary found in $DWM_CONFIG_DIR"
else
    print_message $YELLOW "Warning: DWM binary not found in $DWM_CONFIG_DIR. Please ensure DWM is installed correctly."
fi
