#!/bin/bash

sudo chown -R steam:steam /home/steam

# ArmA3
mkdir -p "/home/steam/.local/share/Arma 3"
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"

cd /opt/steamer
chmod +x ./arma3server
sed -i "s/username/$STEAM_USERNAME/" ./arma3server
sed -i "s/password/$STEAM_PASSWORD/" ./arma3server
sed -i "s/ip=\"0\.0\.0\.0\"/ip=\"$IP\"/" ./arma3server
sed -i "s/port=\"2302\"/port=\"$PORT\"/" ./arma3server

cd /home/steam
/opt/steamer/arma3server auto-install
sudo chown -R steam:steam /home/steam
