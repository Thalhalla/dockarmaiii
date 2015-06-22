#!/bin/bash

cd /home/steam
./arma3server start
echo "started server"
sleep 10
echo "retreiving details"
sleep 3
./arma3server details
sleep 300
# infinite loop to keep it open for Docker
while true; do ./arma3server monitor; sleep 300; done
