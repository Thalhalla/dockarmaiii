#!/bin/sh

cd /assets
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_GID/" steamer.txt
cd ~/steamcmd
./steamcmd.sh +runscript /assets/steamer.txt
bash /assets/run.sh
