#!/bin/bash

cd /home/steam
# valve-way
# /assets/valve-way.sh
# /home/steam/arma3/arma3server -ip=4.31.168.84 -port=2302

# LGSM way
/bin/bash /assets/valve-way.sh
#tail -f /var/steam/log/console/arma3-server-console.log
cd /home/steam/serverfiles/arma3
while [ 1 ]
do
    ./arma3server -netlog -ip=0.0.0.0 -port=$PORT -cfg=/home/steam/serverfiles/arma3/cfg/arma3-server.network.cfg -config=/home/steam/arma3/serverfiles/cfg/arma3-server.server.cfg -mod= -servermod= -bepath= -autoinit -loadmissiontomemory
    sleep 3
    echo restarting
    sleep 3
done
