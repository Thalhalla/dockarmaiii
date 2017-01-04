#!/bin/bash

sudo chown -R steam. /home/steam
#mkdir /home/steam/serverfiles/arma3

# ArmA3
mkdir -p "/home/steam/.local/share/Arma 3"
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"
cd /home/steam
tar zxf /opt/steamer/steamcmd_linux.tar.gz

# run the server
bash /assets/run.sh
