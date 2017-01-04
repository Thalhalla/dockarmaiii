# steamer
Docker that contains steam, caution steam can cause severe burns!

## Usage

##### Local build
`make build`

to build the image locally

##### Pull
or `make pull` to pull the image from docker hub

##### Run
after which you can run with

`make run`

### MAnual Install
after pulling or building:

`make install`

will start the container with `/bin/bash` so you can go in and verify
the install goes fine, which you can do by `make enter` to enter the container.

where you can then install by doing `/assets/start.sh`

alternatively you can do this all manually:

## Caveats

I make a dedicated serving account and turn off steamguard, otherwise
you have to wade through the notes below:

#### old method 

-- use the above steamcmdinstaller3.9.sh for an automated walkthrough of getting the steamguard token

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
