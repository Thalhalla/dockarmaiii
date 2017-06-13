#!/bin/bash

#mkdir /home/steam/serverfiles/arma3

# ArmA3
mkdir -p "/home/steam/.local/share/Arma 3"
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"
cd /home/steam

#/opt/steamer/arma3server start
echo "ServerIP = $SERVER_IP"
echo "ServerPORT = $SERVER_PORT"

#tail -f /var/steam/log/console/arma3-server-console.log
cd /home/steam/serverfiles

while [ 1 ]
do
    ./arma3server -client -connect=$SERVER_IP -port=$SERVER_PORT -password=$GAME_PASSWORD -mod=$MODS
    echo monitor the headless client here
    sleep 300
done
