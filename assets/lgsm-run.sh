#!/bin/bash
cd /home/steam

/opt/steamer/arma3server start
sleep 10
cd /home/steam/serverfiles/arma3
while [ 1 ]
do
    /opt/steamer/arma3server monitor
    sleep 300
done
