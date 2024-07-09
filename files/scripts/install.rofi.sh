#!/bin/bash

#install rofi in arch
#To install Rofi on Arch Linux, you have a few options. You can use the Snap Store and install the rofi-snap package, or you can use the Arch User Repository (AUR) and install the rofi package.

#To install rofi using the AUR, you can use the following command:

# sudo pacman -S rofi

#Then, to configure rofi, you can use the following command:

# rofi -show-icons -icon-theme Papirus -combi-modi window#drun#ssh

#This will display icons for the corresponding entries and define the icon theme. You can also use the following command to bind a key to launch rofi:

# rofi -combi-modi window#drun#ssh

#You can also customize the behavior of rofi by editing the configuration file. For example, you can use the following command to add a new mode to rofi:

# rofi -mode search

#You can also use the following command to add a new application to the menu:

# rofi -add-application Thunar

##Note that you will need to have papirus-icon-theme installed for rofi to display icons. You can install it using the following command:

# sudo pacman -S papirus-icon-theme

#It’s worth noting that rofi has a lot of customization options, and you can customize it to fit your needs. The ArchWiki page for rofi has more information on how to customize rofi.



# Install rofi
sudo pacman -Syu --noconfirm rofi

# Create the rofi configuration directory
mkdir -p ~/.config/rofi

# Create a basic rofi config file
cat <<EOL > ~/.config/rofi/config.rasi
configuration {
    modi: "drun,run";
    font: "mono 12";
    show-icons: true;
    theme: "gruvbox-dark";
}

@theme "gruvbox-dark" {
    /* Configuration for gruvbox dark theme */
    * {
        background-color:    #282828;
        text-color:          #ebdbb2;
        border-color:        #928374;
        separator-color:     #928374;
        background:          #282828;
        background-alt:      #3c3836;
        foreground:          #ebdbb2;
        selected:            #fe8019;
        urgent:              #fb4934;
        active:              #b8bb26;
    }
}
EOL

# Optional: Create a simple theme for rofi (if required)
mkdir -p ~/.config/rofi/themes
cat <<EOL > ~/.config/rofi/themes/gruvbox-dark.rasi
* {
    background-color:    #282828;
    text-color:          #ebdbb2;
    border-color:        #928374;
    separator-color:     #928374;
    background:          #282828;
    background-alt:      #3c3836;
    foreground:          #ebdbb2;
    selected:            #fe8019;
    urgent:              #fb4934;
    active:              #b8bb26;
}

window {
    border: 2px;
    padding: 10px;
    width: 50%;
    height: 50%;
}
EOL

# Print completion message
echo "Rofi has been installed and configured successfully."
