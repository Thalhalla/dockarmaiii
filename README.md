# steamer
Docker that contains steam, caution steam can cause severe burns!

## Usage

`make install`

then to enter the container:
`make enter`

where you can then install by doing `/assets/steamcmdinstaller3.9.sh`

follow the prompts

you look for newer scripts [here](https://github.com/Gousaid67/steam-cmd-installer)

with your game server installed you can then
replace `assets/steamer.txt` with a custom script of your own,
and replace `assets/run.sh` with the server command then finally

`make run`

## Caveats
Because of the Steam Guard Token. You must get into the VM, login as the steam user and incant `/home/steam/steamcmd/steamcmd.sh`,
then at the steam prompt type `login $STEAM_USER $STEAM_PASSWORD` with the steam credentials for your dedicated server account 
(it is recommended you make a separate account for each dedicated server you put up)

I’m looking for a good way to automate this process.

At this point you will have to do the dance to get the steam token.

And to make all this persistent you’ll need to -v mount at least the steam directories, but I’ve just been mounting the entire /home/steam directory so I can save maps and other things out as well YMMV

you can see an example here that I made for octohost.io
https://github.com/Thalhalla/armocto

saving the directory before migrating to octohost can be a tricky step.  Essentially I run `make run` on this project:
http://thalhalla.github.io/dockarmaiii/
and copy the home directory out at that time.  Then copy over to my octohost into the `/exports/armocto` directory

view the dev docs here on creating a script for the steamcmd:
https://developer.valvesoftware.com/wiki/SteamCMD#Creating_a_script
that is the same as the default steamer.txt given here

main website here:
http://joshuacox.github.io/steamer/


[![Stories in Ready](https://badge.waffle.io/joshuacox/steamer.png?label=ready&title=Ready)](https://waffle.io/joshuacox/steamer)
