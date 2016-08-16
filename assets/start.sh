#!/bin/bash

# ArmA3
mkdir -p "/home/steam/.local/share/Arma 3" 
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"

cp /assets/steamer.txt /home/steam/
cd /home/steam
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt
bash /home/steam/steamcmd/steamcmd.sh +runscript /home/steam/steamer.txt
bash /assets/run.sh
