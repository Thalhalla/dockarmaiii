#!/bin/bash

cd /home/steam
# valve-way
# /assets/valve-way.sh
# /home/steam/arma3/arma3server -ip=4.31.168.84 -port=2302

# LGSM way
/bin/bash /assets/valve-way.sh
#tail -f /var/steam/log/console/arma3-server-console.log
sleep 60
echo sleep
while [ 1 ]
do
    echo sleep
    sleep 300
done
