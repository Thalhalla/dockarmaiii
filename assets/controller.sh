#!/bin/bash

main() {
  # perform pre-install configuration
  # source /etc/myvars

  if [ ! -z ${FORCEUPDATE+x} ] || [ ! -f /home/steam/serverfiles/app_update_date ]
    then
      do_update
  fi

  if [ ! -f /home/steam/steamer.txt ]
    then
      do_config
  fi

  # and startup
  startup
}

startup() {
  # perform post-install configuration
  source /assets/config.sh
  cd /home/steam/serverfiles
  while [ 1 ]
  do
    eval ./arma3server $CMDSTRING
    sleep 30
    echo restarting
    sleep 30
  done

}

do_update() {
  mkdir -p /home/steam/serverfiles/arma3
  cd /opt/steamer
  ./steamcmd.sh +runscript /home/steam/steamer.txt
  cd /home/steam
  date -I > /home/steam/serverfiles/app_update_date
  sudo chown -R steam:steam /home/steam
}

do_config() {
  sudo chown -R steam:steam /home/steam
  cp /assets/steamer.txt /home/steam/
  cd /home/steam
  #ln -s '/home/steam/Steam/steamapps/common/Arma 3 Server' arma3
  sed -i "s/REPLACEME_USERNAME/$STEAM_USERNAME/" steamer.txt
  sed -i "s/REPLACEME_PASSWORD/$STEAM_PASSWORD/" steamer.txt
  sed -i "s/REPLACEME_GID/$STEAM_GID/" steamer.txt
}

main "$@"
