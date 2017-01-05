#!/bin/bash

sudo chown -R steam. /home/steam
#mkdir /home/steam/serverfiles/arma3

# ArmA3
mkdir -p "/home/steam/.local/share/Arma 3"
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"
cd /home/steam

/bin/bash /assets/install.sh

#/opt/steamer/arma3server start
echo 'Show environment vars'
echo "ServerIP = $SERVER_IP"
echo "ServerPORT = $SERVER_PORT"
echo start the headless client here
sleep 10
#tail -f /var/steam/log/console/arma3-server-console.log
cd /home/steam/serverfiles/arma3
while [ 1 ]
do
    /opt/steamer/arma3server monitor
    echo monitor the headless client here
    sleep 300
done
