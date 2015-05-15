#!/bin/bash

cd /home/steam
sed -i "s/steamuser=\"username\"/steameruser=\"$STEAM_USERNAME\"/" arma3server
sed -i "s/steampass=\"password\"/steamerpass=\"$STEAM_PASSWORD\"/" arma3server
./arma3server install
bash /home/steam/run.sh
