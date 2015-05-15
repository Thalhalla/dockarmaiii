#!/bin/sh

cd /home/steam
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
cd ~/steamcmd
./steamcmd.sh +runscript /home/steam/steamer.txt
bash /home/steam/run.sh

