#!/bin/bash

# if these aren't present the server will segfault/coredump
mkdir -p "/home/steam/.local/share/Arma 3"
mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"

mkdir -p /home/steam/profiles
cd /home/steam

cp /assets/arma3-server.server.cfg ./
cp /assets/arma3-server.network.cfg ./

sed -i  "s/^headlessClients.*/headlessClients[]=\{\"$CLIENT_IP\", \"$CLIENT_IP2\", \"$CLIENT_IP3\", \"$CLIENT_IP4\", \"$CLIENT_IP5\", \"$CLIENT_IP6\" \};/" ./arma3-server.server.cfg
sed -i  "s/^localClient.*/localClient[]=\{\"$CLIENT_IP\", \"$CLIENT_IP2\", \"$CLIENT_IP3\", \"$CLIENT_IP4\", \"$CLIENT_IP5\", \"$CLIENT_IP6\" \};/" ./arma3-server.server.cfg
sed -i  "s/^passwordAdmin.*/passwordAdmin = \"$ADMIN_PASSWORD\";/" ./arma3-server.server.cfg
sed -i  "s/^hostname.*/hostname = \"$HOSTNAME\";/" ./arma3-server.server.cfg
sed -i  "s/^maxPlayers.*/maxPlayers = \"$MAX_PLAYERS\";/" ./arma3-server.server.cfg

# set the server aspect (--server/--client)
if [[ ${HEADLESS_CLIENT} ]]
  then
    ASPECT="-client"
else
    ASPECT="-server"
fi

if [[ $MODS ]]
  then
    # format the MODS string to escape ;
    export MODS=$(echo "$MODS"  | sed 's|;|\\;|g')
    MODSTRING="-mod=$MODS"
else
    MODSTRING=""
fi

# set the port
if [[ $PORT ]]
  then
    PORTSTRING="-port=$PORT"
else
    PORTSTRING="-port=2302"
fi

# format the SERVERMODS string to escape ;
export SERVERMODS=$(echo "$SERVERMODS"  | sed 's|;|\\;|g')
if [[ $SERVERMODS ]]
  then
    SERVERMODSTRING="-servermod=$SERVERMODS"
else
    SERVERMODSTRING=""
fi

export CMDSTRING="-netlog $ASPECT -pid=/home/steam/arma3server.pid -ranking=/home/steam/ranking.log -ip=0.0.0.0 $PORTSTRING -profiles=/home/steam/profiles -cfg=/home/steam/arma3-server.network.cfg -config=/home/steam/arma3-server.server.cfg -bepath=/data/battleye $MODSTRING $SERVERMODSTRING"
