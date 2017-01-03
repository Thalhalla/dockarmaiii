#!/bin/bash

# valve-way
# /assets/valve-way.sh
# /home/steam/arma3/arma3server -ip=4.31.168.84 -port=2302

# LGSM way
/assets/lgsm.sh
sleep 10
#tail -f /var/steam/log/console/arma3-server-console.log
sleep 60
echo sleep
while [ 1 ]
do
    /home/steam/arma3server monitor
    sleep 60
done
