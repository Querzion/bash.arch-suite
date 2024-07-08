#!/bin/bash

# Install Thunar & dependencies through AUR
yay -S thunar --noconfirm

# Install Thunar Extensions
yay -S thunar-volman imdb-thumbnailer --noconfirm

# Install Thunar Plugins
yay -S thunar-shares-plugin thunar-media-tags-plugin thunar-archive-plugin --noconfirm
