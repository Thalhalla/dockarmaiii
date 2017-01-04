#!/bin/bash

mkdir -p /home/steam/serverfiles/arma3
cp /assets/steamer.txt /home/steam/
cd /home/steam
tar zxf /opt/steamer/steamcmd_linux.tar.gz
#ln -s '/home/steam/Steam/steamapps/common/Arma 3 Server' arma3
sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt
bash /home/steam/steamcmd.sh +runscript /home/steam/steamer.txt

cd /home/steam/serverfiles/arma3
./arma3server -netlog -ip=0.0.0.0 -port=$PORT -cfg=/home/steam/serverfiles/arma3/cfg/arma3-server.network.cfg -config=/home/steam/arma3/serverfiles/cfg/arma3-server.server.cfg -mod= -servermod= -bepath= -autoinit -loadmissiontomemory
