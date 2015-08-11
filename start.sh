#!/bin/bash

cd /home/steam
echo sed
sed -i 's/steamuser="username"/steamuser=REPLACE_USER/' arma3server
sed -i 's/steampass="password"/steampass=REPLACE_PASSWORD/' arma3server
sed -i "s/steamuser=REPLACE_USER/steamuser='$STEAM_USERNAME'/" arma3server
sed -i "s/steampass=REPLACE_PASSWORD/steampass='$STEAM_PASSWORD'/" arma3server
set_steam_guard_code $STEAM_GUARD_CODE
yes y|./arma3server install
/bin/bash /run.sh
