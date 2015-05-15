#!/bin/sh

cd /home/steam
sed -i s/REPLACEME_USERNAME/$STEAM_USERNAME/ steamer.txt
sed -i s/REPLACEME_PASSWORD/$STEAM_PASSWORD/ steamer.txt
cd ~/steamcmd
sudo -i -u steam ./steamcmd.sh +runscript /home/steam/steamer.txt
sudo -i -u steam bash /home/steam/run.sh

