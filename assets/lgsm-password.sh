#!/bin/bash

/assets/lgsm-install.sh
/assets/password.sh
cd /home/steam
/opt/steamer/arma3server start
sleep 10
while [ 1 ]
do
    /opt/steamer/arma3server monitor
    sleep 300
done
