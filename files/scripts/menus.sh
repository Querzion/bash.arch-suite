#!/bin/bash

# Function to install GNOME, Plasma, COSMIC, or DTOS
install_suite() {
  case $1 in
    "gnome")
      bash ~/bash.arch-startup/files/scripts/install.gnome-suite.sh
      ;;
    "plasma")
      bash ~/bash.arch-startup/files/scripts/install.plasma-suite.sh
      ;;
    "cosmic")
      bash ~/bash.arch-startup/files/scripts/install.cosmic-suite.sh
      ;;
    "dtos")
      bash ~/bash.arch-startup/files/scripts/qtile/install.dtos.sh
      ;;
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
}

# Function for DWM variants menu
dwm_menu() {
  echo "Choose DWM variant:"
  echo "1. QnDWM"
  echo "2. Afnarel-DWM  (Not Fixed Yet)"
  echo "3. ArcoDWM (Not Fixed Yet)"
  echo "4. ChaDWM (Not Fixed Yet)"
  echo "5. DWM-FlexiPatch (Not Fixed Yet)"
  echo "6. DWM-Titus (Not Fixed Yet)"
  echo "7. DTOS-DWM (Not Fixed Yet)"
  read -p "Enter your choice [1-7]: " dwm_choice

  case $dwm_choice in
    1)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.qndwm.sh
      ;;
    2)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.afnarel-dwm.sh
      ;;
    3)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.arcodwm.sh
      ;;
    4)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.chadwm.sh
      ;;
    5)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.dwm-flexipatch.sh
      ;;
    6)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.dwm-titus.sh
      ;;
    7)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.dtos-dwm.sh
      ;;
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
}

# Function for Hyprland variants menu
hyprland_menu() {
  echo "Choose Hyprland variant:"
  echo "1. Hyprlaqnd (Not Fixed Yet)"
  echo "2. End 4 Dots (Not Fixed Yet)"
  echo "3. Hyprdots (Not Fixed Yet)"
  echo "4. Jakoolit Dots (Not Fixed Yet)"
  echo "5. Linux Mobile (Not Fixed Yet)"
  echo "6. Taylor Dots (Not Fixed Yet)"
  echo "7. Hyprland Starter"
  read -p "Enter your choice [1-7]: " hyprland_choice

  case $hyprland_choice in
    1)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.hyprlaqnd.sh
      ;;
    2)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.end4dots.sh
      ;;
    3)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.hyprdots.sh
      ;;
    4)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.jakoolit-dots.sh
      ;;
    5)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.linuxmobile.sh
      ;;
    6)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.taylordots.sh
      ;;
    7)
      bash ~/bash.arch-startup/files/scripts/hyprland/hyprland.starter.sh
      ;;
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
}

# Main menu
echo "Choose the environment you want to install:"
echo "1. GNOME (Not Fixed Yet)"
echo "2. Plasma (Not Fixed Yet)"
echo "3. COSMIC (Not Fixed Yet)"
echo "4. DTOS"
echo "5. DWM"
echo "6. Hyprland"
read -p "Enter your choice [1-6]: " main_choice

case $main_choice in
  1)
    install_suite "gnome"
    ;;
  2)
    install_suite "plasma"
    ;;
  3)
    install_suite "cosmic"
    ;;
  4)
    install_suite "dtos"
    ;;
  5)
    dwm_menu
    ;;
  6)
    hyprland_menu
    ;;
  *)
    echo "Invalid option. Please choose a valid option."
    ;;
esac
