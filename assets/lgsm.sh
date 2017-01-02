#!/bin/bash
cd /home/steam
wget -c https://gameservermanagers.com/dl/arma3server
chmod +x arma3server
sed -i "s/username/$STEAM_USERNAME/" /home/steam/arma3server
sed -i "s/password/$STEAM_PASSWORD/" /home/steam/arma3server
sed -i "s/ip=\"0\.0\.0\.0\"/ip=\"$IP\"/" /home/steam/arma3server
sed -i "s/port=\"2302\"/port=\"$PORT\"/" /home/steam/arma3server

/home/steam/arma3server auto-install
/home/steam/arma3server start
