#!/bin/bash

mkdir -p /home/steam/serverfiles/cfg
cd /home/steam/serverfiles/cfg

cp /assets/arma3-server.server.password.cfg ./
cp /assets/arma3-server.network.cfg ./

sed -i  "s/^headlessClients.*/headlessClients[]=\{\"$CLIENT_IP\", \"$CLIENT_IP2\", \"$CLIENT_IP3\", \"$CLIENT_IP4\", \"$CLIENT_IP5\", \"$CLIENT_IP6\" \};/" ./arma3-server.server.cfg
sed -i  "s/^localClient.*/localClient[]=\{\"$CLIENT_IP\", \"$CLIENT_IP2\", \"$CLIENT_IP3\", \"$CLIENT_IP4\", \"$CLIENT_IP5\", \"$CLIENT_IP6\" \};/" ./arma3-server.server.cfg
sed -i  "s/^passwordAdmin.*/passwordAdmin = \"$ADMIN_PASSWORD\";/" ./arma3-server.server.cfg
sed -i  "s/^hostname.*/hostname = \"$HOSTNAME\";/" ./arma3-server.server.cfg
sed -i  "s/^password\ =.*/password = \"$GAME_PASSWORD\";/" ./arma3-server.server.cfg

cd /opt/steamer
chmod +x ./arma3server
sed -i "s/username/$STEAM_USERNAME/" ./arma3server
sed -i "s/password/$STEAM_PASSWORD/" ./arma3server
sed -i "s/ip=\"0\.0\.0\.0\"/ip=\"$IP\"/" ./arma3server
sed -i "s/port=\"2302\"/port=\"$PORT\"/" ./arma3server
