#!/bin/bash
cd /opt/steamer
sed -i "s/username/$STEAM_USERNAME/" /home/steam/arma3server
sed -i "s/password/$STEAM_PASSWORD/" /home/steam/arma3server
sed -i "s/ip=\"0\.0\.0\.0\"/ip=\"$IP\"/" /home/steam/arma3server
sed -i "s/port=\"2302\"/port=\"$PORT\"/" /home/steam/arma3server

cd /home/steam/
/opt/steamer/arma3server auto-install

# https://steamcommunity.com/discussions/forum/1/618456760281557146/?ctp=2
sudo chown -R steam. /home/steam

# Start
cd /home/steam
/home/steam/arma3server start
