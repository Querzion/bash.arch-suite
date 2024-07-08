# Arch Linux Setup with dwm Installation Script

This repository contains scripts and instructions for setting up an Arch Linux system with dwm (Dynamic Window Manager) and other essential applications. It starts of installing Paru & Yay from their git repositories for access to the AUR, after that it installs the applications in the txt file applications. When it's done with that it will start downloading dwm, st, dmenu & nnn from suckless, and then flatpaks are installed. Last is to copy config files and other scripts, like adding text to .xinitrc, copying a .bashrc that has a multitude of useful alias commands pre-created. Configs (config.def.h) for dwm, st & dmenu will be copied to their folders, the old one will be renamed (confid.def.h.bak) and the command "sudo make clean install" will be used, last startx will be added to .bashrc. Other changes that will be added to the system are the change to Swedish Dvorak. If this is not to your liking there are alias commands in the .bashrc that will change to other keyboard layouts.  

## Installation

To automate the installation of applications and configure dwm, follow these steps:

1. **Install Git:**
   ```bash
   sudo pacman -S git
   ```
2. **Clone the Repository:**
   ```bash
   git clone https://github.com/querzion/bash.dwm-arch.startup.git ~/startup
   ```
3. **Make Executable:**
   ```bash
   cd startup
   chmod +x install.dwm-arch.sh
   ```
4. **Start:**
   ```bash
   ./install.dwm-arch.sh
   ```
5. **Reboot:**
   ```bash
   reboot
   ```

Change the files however you like, I have it be like this because it's what I 'need' to have installed, but I will probably make separate applications, games, streaming, vm repos that is then added to this. Right now however, this is going to have to do. 
