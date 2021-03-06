#!/bin/bash
if [ -z ${STEAMER_FILE+x} ]
  then
      STEAMER_FILE=steamer.txt
fi

sudo chown -R steam:steam /home/steam
mkdir -p /home/steam/serverfiles/arma3
cp /assets/$STEAMER_FILE /home/steam/steamer.txt
cd /home/steam
#ln -s '/home/steam/Steam/steamapps/common/Arma 3 Server' arma3
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt

cd /opt/steamer
./steamcmd.sh +runscript /home/steam/steamer.txt
cd /home/steam
sudo chown -R steam:steam /home/steam
