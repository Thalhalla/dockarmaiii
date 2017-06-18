#!/bin/bash
source /etc/myvars

if [ ! -z ${FORCEUPDATE+x} ]
  then
    sudo chown -R steam:steam /home/steam
    mkdir -p /home/steam/serverfiles/arma3
    cp /assets/steamer.txt /home/steam/
    cd /home/steam
    #ln -s '/home/steam/Steam/steamapps/common/Arma 3 Server' arma3
    sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
    sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
    sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt

    cd /opt/steamer
    ./steamcmd.sh +runscript /home/steam/steamer.txt
    cd /home/steam
    sudo chown -R steam:steam /home/steam
    date -I > /home/steam/serverfiles/app_update_date
fi

# set vars and startup
cd /home/steam

# perform post-install configuration
source /assets/config.sh

#tail -f /var/steam/log/console/arma3-server-console.log

cd /home/steam/serverfiles
while [ 1 ]
do
  eval ./arma3server $CMDSTRING
  sleep 3
  echo restarting
  sleep 3
done
