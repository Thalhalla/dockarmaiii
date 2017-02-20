#!/bin/bash

cd /home/steam
# valve-install
# /assets/valve-install.sh
# /home/steam/arma3/arma3server -ip=4.31.168.84 -port=2302

# LGSM way
#/bin/bash /assets/valve-install.sh
/bin/bash /assets/config.sh
#tail -f /var/steam/log/console/arma3-server-console.log
cd /home/steam/serverfiles
while [ 1 ]
do
    eval ./arma3server -netlog -ip=0.0.0.0 -port=2302 -cfg=/home/steam/serverfiles/cfg/arma3-server.network.cfg -config=/home/steam/serverfiles/cfg/arma3-server.server.cfg -mod=$MODS -serverMod=$SERVERMODS -bepath=/home/steam/serverfiles/battleye/ -loadMissionToMemory
    sleep 3
    echo restarting
    sleep 3
done
