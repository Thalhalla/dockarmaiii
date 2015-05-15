# dockarmaiii
Arma III dedicated Docker container

uses LGSM to build and run:
https://github.com/dgibbs64/linuxgsm/wiki/Install#ARMA-3
old instructions here (contains more info)
http://danielgibbs.co.uk/lgsm/arma3server/

simply `make run` you will be prompted for your username and password
you will need to set the STEAM_ USERNAME and PASSWORD variables in your derivative Dockerfile
https://community.bistudio.com/wiki/Arma_3_Dedicated_Server

alternatively copy steamer.tpl to steamer.txt and edit as you like

main website:
http://thalhalla.github.io/dockarmaiii/
