# Arch Linux Setup with dwm Installation Script

This repository contains scripts and instructions for setting up an Arch Linux system with dwm (Dynamic Window Manager) and other essential applications.

## Installation

To automate the installation of applications and configure dwm, follow these steps:

1. **Install Git:**
   ```bash
   sudo pacman -S git
   ```
2. **Clone the Repository:**
   ```bash
   git clone https://github.com/querzion/startup.dwm-arch.git
   ```
3. **Make Executable:**
   ```bash
   cd startup.dwm-arch
   chmod +x install.dwm-arch.sh
   ```
4. **Start:**
   ```bash
   ./install.dwm-arch.sh
   ```

## Applications "files/applications.txt"
 - vim
 - nano
 - bluez
 - bluez-utils
 - blueman
 - firefox
 - btop
 - fastfetch
 - pipewire
 - pipewire-pulse
 - pavucontrol
 - xbindkeys
 - xev
 - exa
 - xorg
 - xorg-server
 - xorg-xinit
 - xorg-xkb-layouts
 - make
 - gcc
 - libx11
 - libxft
 - libxinerama
 - base-devel
 - webkit2gtk
 - nodejs
 - npm
 - mpv
 - python
 - code
 - dotnet-sdk
 - dotnet-runtime
 - vlc
 - flatpak
 - docker

## Applications "install.dwm-arch.sh"
 - flatpak source
 - docker services
 - brave-browser
 - discord
 - obs-studio 

Change the files however you like, I have it be like this because it's what I 'need' to have installed, but I will probably make separate applications, games, streaming, vm repos that is then added to this. Right now however, this is going to have to do. 
