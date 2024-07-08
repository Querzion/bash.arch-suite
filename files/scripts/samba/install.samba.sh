#!/bin/bash
set -e
##################################################################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxforum.com
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

sudo pacman -S --noconfirm --needed samba
sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf.original
sudo wget "https://raw.githubusercontent.com/arcolinux/arcolinux-system-config/master/etc/samba/smb.conf.arcolinux" -O /etc/samba/smb.conf.arcolinux
sudo wget "https://raw.githubusercontent.com/arcolinux/arcolinux-system-config/master/etc/samba/smb.conf.arcolinux" -O /etc/samba/smb.conf
sudo systemctl enable smb.service
sudo systemctl start smb.service
sudo systemctl enable nmb.service
sudo systemctl start nmb.service

##Change your username here
read -p "What is your login? It will be used to add this user to smb : " choice
sudo smbpasswd -a $choice

#access samba share windows
sudo pacman -S --noconfirm --needed gvfs-smb

echo "################################################################"
echo "#########   samba  software installed           ################"
echo "################################################################"

echo "Network Discovery"

sudo pacman -S --noconfirm --needed avahi
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service

#shares on a mac
sudo pacman -S --noconfirm --needed nss-mdns

tput setaf 5;echo "################################################################"
echo "Change /etc/nsswitch.conf for access to nas servers"
echo "We assume you are on ArcoLinux and have"
echo "arcolinux-system-config-git or arcolinuxd-system-config-git"
echo "installed. Else check and change the content of this file to your liking"
echo "################################################################"
echo;tput sgr0

# https://wiki.archlinux.org/title/Domain_name_resolution
if [ -f /usr/local/share/arcolinux/nsswitch.conf ]; then
	echo "Make backup and copy ArcoLinux conf over"
	echo
	sudo cp /etc/nsswitch.conf /etc/nsswitch.conf.bak
	sudo cp /usr/local/share/arcolinux/nsswitch.conf /etc/nsswitch.conf
fi

echo "################################################################"
echo "####       network discovery  software installed        ########"
echo "################################################################"

#source fedora 23 : https://opsech.io/posts/2016/Apr/06/sharing-files-with-kde-and-samba.html

if pacman -Qi samba &> /dev/null; then
  echo "###################################################################"
  echo "Samba is installed"
  echo "###################################################################"
else
  tput setaf 1;echo "###################################################################"
  echo "First use our scripts to install samba and/or network discovery"
  echo "###################################################################";tput sgr0
  exit 1
fi

FILE=/etc/samba/smb.conf

if test -f "$FILE"; then
    echo "/etc/samba/smb.conf has been found"
else
  tput setaf 1;echo "###################################################################"
  echo "We did not find /etc/samba/smb.conf"
  echo "First use our scripts to install samba and/or network discovery"
  echo "###################################################################";tput sgr0
  exit 1
fi


#checking if filemanager is installed then install extra packages
if pacman -Qi nemo &> /dev/null; then
  sudo pacman -S --noconfirm --needed nemo-share
fi
if pacman -Qi nautilus &> /dev/null; then
  sudo pacman -S --noconfirm --needed nautilus-share
fi
if pacman -Qi caja &> /dev/null; then
  sudo pacman -S --noconfirm --needed caja-share
fi
if pacman -Qi dolphin &> /dev/null; then
  sudo pacman -S --noconfirm --needed kdenetwork-filesharing
fi
if pacman -Qi thunar &> /dev/null; then

  echo "Select what package you would like to install"

  echo "0.  Do nothing"
  echo "1.  ArcoLinux-thunar-shares-plugin - PREFERRED"
  echo "2.  Default thunar-shares-plugin"
  echo "3.  Default thunar-shares-plugin-git"
  echo "Type the number..."

  read CHOICE

  case $CHOICE in

      0 )
        echo
        echo "########################################"
        echo "We did nothing as per your request"
        echo "########################################"
        echo
        ;;
      1 )
        sudo pacman -S --noconfirm --needed arcolinux-thunar-shares-plugin
        ;;
      2 )
        sudo pacman -S --noconfirm --needed thunar-shares-plugin
        ;;
      3 )
        sudo pacman -S --noconfirm --needed thunar-shares-plugin-git
        ;;
      * )
        echo "#################################"
        echo "Choose the correct number"
        echo "Nothing installed - install manually"
        echo "#################################"
        ;;
    esac
fi

file="/etc/samba/smb.conf"

sudo sed -i '/^\[global\]/a \
\
usershare allow guests = true \
usershare max shares =  50 \
usershare owner only = true \
usershare path = /var/lib/samba/usershares' $file


sudo mkdir -p /var/lib/samba/usershares
sudo groupadd -r sambashare
sudo gpasswd -a $USER sambashare
sudo chown root:sambashare /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares

tput setaf 1;echo "###################################################################"
echo "Now reboot before sharing folders"
echo "###################################################################";tput sgr0
