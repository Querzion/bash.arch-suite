

################################################################### ST
############ ST

echo -e "${PURPLE} Installing st. ${NC}"

# Install st (suckless terminal)
echo "Installing st (suckless terminal)..."
git clone https://git.suckless.org/st $DIR/$USER/st
cd $DIR/$USER/st
sudo make clean install

echo -e "${GREEN} st installed successfully. ${NC}"

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
#sudo mv ~/.config/st/config.def.h ~/.config/st/config.def.h.bak
sudo cp $CONF_F/st/config.def.h ~/.config/st/config.def.h.new

cd $DIR/$USER/st

sudo rm config.h
sudo make clean install

echo -e "${GREEN} st is now reconfigured. ${NC}"

echo -e "${PURPLE} Patching st. ${NC}"

# Patch st
sh $PATCH_ST

echo -e "${GREEN} st is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### DMENU
############ DMENU

echo -e "${GREEN} Installing dmenu. ${NC}"

# Install dmenu (dynamic menu)
echo "Installing dmenu (dynamic menu)..."
git clone https://git.suckless.org/dmenu $DIR/$USER/dmenu
cd $DIR/$USER/dmenu
sudo make clean install

echo -e "${GREEN} dmenu installed successfully. ${NC}"

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
#sudo mv ~/.config/dmenu/config.def.h ~/.config/dmenu/config.def.h.bak
sudo cp $CONF_F/dmenu/config.def.h ~/.config/dmenu/config.def.h.new

cd $DIR/$USER/dmenu
sudo rm config.h

sudo make clean install

echo -e "${GREEN} dmenu is now reconfigured. ${NC}"

echo -e "${PURPLE} Patching dmenu. ${NC}"

# Patch dmenu
sh $PATCH_DMENU

echo -e "${GREEN} dmenu is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### SLSTATUS
############ SLSTATUS

echo -e "${GREEN} Installing slstatus. ${NC}"

# Install slstatus (taskbar status)
echo "Installing slstatus (Taskbar Status)..."
git clone https://git.suckless.org/slstatus $DIR/$USER/slstatus
cd $DIR/$USER/slstatus
sudo make clean install

echo -e "${GREEN} slstatus installed successfully. ${NC}"

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"

# Copy to replace config.def.h
#sudo mv ~/.config/slstatus/config.def.h ~/.config/slstatus/config.def.h.bak
sudo cp $CONF_F/slstatus/config.def.h ~/.config/slstatus/config.def.h.new

cd $DIR/$USER/slstatus
sudo rm config.h

sudo make clean install

echo -e "${GREEN} slstatus is now reconfigured. ${NC}"

echo -e "${PURPLE} Patching slstatus. ${NC}"

# Patch slstatus
sh $PATCH_SLSTATUS

echo -e "${GREEN} slstatus is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### NNN
############ NNN

echo -e "${PURPLE} Installing nnn. ${NC}"

# Install nnn (file manager)
echo "Installing nnn (file manager)..."
git clone https://github.com/jarun/nnn $DIR/$USER/nnn
cd $DIR/$USER/nnn
sudo make
sudo make install

echo -e "${GREEN} nnn installed successfully. ${NC}"
