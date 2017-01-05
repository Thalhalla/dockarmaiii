#!/bin/bash
cd /opt/steamer
sed -i "s/username/$STEAM_USERNAME/" /opt/steamer/arma3server
sed -i "s/password/$STEAM_PASSWORD/" /opt/steamer/arma3server
sed -i "s/ip=\"0\.0\.0\.0\"/ip=\"$IP\"/" /opt/steamer/arma3server
sed -i "s/port=\"2302\"/port=\"$PORT\"/" /opt/steamer/arma3server

cd /home/steam/
/opt/steamer/arma3server auto-install

# https://steamcommunity.com/discussions/forum/1/618456760281557146/?ctp=2
sudo chown -R steam. /home/steam
