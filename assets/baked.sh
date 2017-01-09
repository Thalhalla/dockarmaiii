#!/bin/bash

#mkdir /home/steam/serverfiles/arma3

# ArmA3
mkdir -p "/home/steam/.local/share/Arma 3"
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"
#tail -f /var/steam/log/console/arma3-server-console.log
/bin/bash /assets/config.sh
cd /home/steam/serverfiles
while [ 1 ]
do
    ./arma3server -netlog -ip=0.0.0.0 -port=$PORT -cfg=/home/steam/serverfiles/cfg/arma3-server.network.cfg -config=/home/steam/serverfiles/cfg/arma3-server.server.cfg -mod=$MODS -servermod= -bepath= -autoinit -loadmissiontomemory
    sleep 3
    echo restarting
    sleep 3
done
