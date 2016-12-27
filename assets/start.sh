#!/bin/bash

# ArmA3
mkdir -p "/home/steam/.local/share/Arma 3"
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"

cp /assets/steamer.txt /home/steam/
cd /home/steam
ln -s '/home/steam/Steam/steamapps/common/Arma 3 Server' arma3
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt
#bash /home/steam/steamcmd/steamcmd.sh +runscript /home/steam/steamer.txt

# skip run for now
bash /assets/run.sh
