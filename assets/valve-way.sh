#!/bin/bash

mkdir -p /home/steam/serverfiles/arma3
cp /assets/steamer.txt /home/steam/
cd /home/steam
#ln -s '/home/steam/Steam/steamapps/common/Arma 3 Server' arma3
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt

cd /opt/steamer
tar zxf /opt/steamer/steamcmd_linux.tar.gz
./steamcmd.sh +runscript /home/steam/steamer.txt

