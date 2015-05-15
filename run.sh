#!/bin/bash

cd /home/steam
./arma3server start
sleep 10
./arma3server details
sleep 300
# infinite loop to keep it open for Docker
while true; do ./arma3server monitor; sleep 300; done
