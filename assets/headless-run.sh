#!/bin/bash

cd /home/steam

# perform config
/bin/bash /assets/config.sh

# check the setup
echo "My IP = $IP"
echo "Target ServerIP = $SERVER_IP"
echo "Target ServerPORT = $SERVER_PORT"
echo "MODS = $MODS"

#tail -f /var/steam/log/console/arma3-server-console.log
cd /home/steam/serverfiles

cmd="./arma3server -client -connect=$SERVER_IP -ip=$IP -port=2302 "
cmd+="-password=$GAME_PASSWORD "
cmd+="-bepath=/home/steam/serverfiles/battleye "
cmd+="-mods=$MODS "
cmd+="-netlog "

while [ 1 ]
do
    echo "executing cmd: $cmd"
    eval $cmd
    sleep 30
    echo restarting
    sleep 3
done
