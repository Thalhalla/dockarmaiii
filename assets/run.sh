#!/bin/bash

cd /home/steam
# valve-way
# /assets/valve-way.sh
# /home/steam/arma3/arma3server -ip=4.31.168.84 -port=2302

# LGSM way
sudo chown -R steam. /home/steam
file="/home/steam/arma3server"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found. Installing"
  /bin/bash /assets/install.sh
fi

/home/steam/arma3server start
sleep 10
#tail -f /var/steam/log/console/arma3-server-console.log
sleep 60
echo sleep
while [ 1 ]
do
    /home/steam/arma3server monitor
    sleep 300
done
