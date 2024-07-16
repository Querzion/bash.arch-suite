#!/bin/bash

# Function to install GNOME, Plasma, or COSMIC
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
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
}

# Function for DWM variants menu
dwm_menu() {
  echo "Choose DWM variant:"
  echo "1. QnDWM"
  echo "2. ChaDWM"
  echo "3. ArcoDWM"
  echo "4. DWM Titus"
  echo "5. DWM-Flexi"
  read -p "Enter your choice [1-5]: " dwm_choice

  case $dwm_choice in
    1)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.QnDWM.sh
      ;;
    2)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.ChaDWM.sh
      ;;
    3)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.ArcoDWM.sh
      ;;
    4)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.DWM-Titus.sh
      ;;
    5)
      bash ~/bash.arch-startup/files/scripts/dwm/variants/install.DWM-Flexi.sh
      ;;
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
}

# Function for Hyprland variants menu
hyprland_menu() {
  echo "Choose Hyprland variant:"
  echo "1. End 4 Dots"
  echo "2. Hyprdots"
  echo "3. Hyprlaqnd"
  echo "4. Jakoolit Dots"
  echo "5. Linux Mobile"
  echo "6. Taylor Dots"
  read -p "Enter your choice [1-6]: " hyprland_choice

  case $hyprland_choice in
    1)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.End4Dots.sh
      ;;
    2)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.Hyprdots.sh
      ;;
    3)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.Hyprlaqnd.sh
      ;;
    4)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.JakoolitDots.sh
      ;;
    5)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.LinuxMobile.sh
      ;;
    6)
      bash ~/bash.arch-startup/files/scripts/hyprland/variants/install.TaylorDots.sh
      ;;
    *)
      echo "Invalid option. Please choose a valid option."
      ;;
  esac
}

# Main menu
echo "Choose the environment you want to install:"
echo "1. GNOME"
echo "2. Plasma"
echo "3. COSMIC"
echo "4. DWM"
echo "5. Hyprland"
read -p "Enter your choice [1-5]: " main_choice

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
    dwm_menu
    ;;
  5)
    hyprland_menu
    ;;
  *)
    echo "Invalid option. Please choose a valid option."
    ;;
esac
