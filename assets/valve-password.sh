#!/bin/bash

/bin/bash /assets/valve-insall.sh
cd /home/steam

/bin/bash /assets/password.sh
cd /home/steam/serverfiles
while [ 1 ]
do
    ./arma3server -netlog -ip=0.0.0.0 -port=$PORT -cfg=/home/steam/serverfiles/cfg/arma3-server.network.cfg -config=/home/steam/serverfiles/cfg/arma3-server.server.cfg -mod=$MODS -servermod= -bepath= -autoinit -loadmissiontomemory
    sleep 3
    echo restarting
    sleep 3
done
