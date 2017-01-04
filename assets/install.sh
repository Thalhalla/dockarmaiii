#!/bin/bash
cd /home/steam
rm -f arma3server
wget -q https://gameservermanagers.com/dl/arma3server
chmod +x arma3server
sed -i "s/username/$STEAM_USERNAME/" /home/steam/arma3server
sed -i "s/password/$STEAM_PASSWORD/" /home/steam/arma3server
sed -i "s/ip=\"0\.0\.0\.0\"/ip=\"$IP\"/" /home/steam/arma3server
sed -i "s/port=\"2302\"/port=\"$PORT\"/" /home/steam/arma3server

/home/steam/arma3server auto-install

# https://steamcommunity.com/discussions/forum/1/618456760281557146/?ctp=2
sudo chown -R steam. /home/steam
cd /home/steam/steamcmd
rm -r ./linux32/
mv ./package/tmp/* /home/steam/steamcmd/

# Start
cd /home/steam
/home/steam/arma3server start
