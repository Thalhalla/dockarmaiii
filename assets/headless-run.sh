#!/bin/bash

cd /home/steam

#/opt/steamer/arma3server start
echo "My IP = $IP"
echo "Target ServerIP = $SERVER_IP"
echo "Target ServerPORT = $SERVER_PORT"

/bin/bash /assets/config.sh

#tail -f /var/steam/log/console/arma3-server-console.log
cd /home/steam/serverfiles

while [ 1 ]
do
    eval ./arma3server -client -connect=$SERVER_IP -ip=$IP -port=2302 \
      -password=$GAME_PASSWORD \
      -mod="$MODS" \
      -bepath=/home/steam/serverfiles/battleye/ \
      -netlog
    sleep 3
    echo restarting
    sleep 3
done
