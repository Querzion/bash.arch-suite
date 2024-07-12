#! /bin/bash

git clone https://github.com/siduck/chadwm --depth 1  ~/.config/chadwm
chmod +x -R ~/.config/chadwm/ 
cd ~/.config/chadwm/
mv eww ~/.config
cd chadwm
sudo make install





