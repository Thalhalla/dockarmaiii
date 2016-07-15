#!/bin/bash
# if you have any issues, open an issue on github

## Change insdir="$PWD" if you want to use the script folder
insdir="$1"
user=""
pass=""
dir=""
appid=""
appmod=""
bool=""
chkhash=""
archit=""
ukwn=""
file="steamcmd.sh"
# try various methods, in order of preference, to detect distro
# store result in variable '$distro'
if type lsb_release >/dev/null 2>&1 ; then
   distro=$(lsb_release -i -s)
elif [ -e /etc/os-release ] ; then
   distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)
elif [ -e /etc/some-other-release-file ] ; then
   distro=$(ihavenfihowtohandleotherhypotheticalreleasefiles)
fi

# convert to lowercase
distro=$(printf '%s\n' "$distro" | LC_ALL=C tr '[:upper:]' '[:lower:]')

# remove the update function (line 49 to line 61 ) if you are customizing the script
#  or  change the first url at line 43 to use a custom update directory(dont forget to change the names of the files in the path)
echo checking update
case "$distro" in
   debian*)  sudo apt-get install git  ;;
   centos*)  sudo yum install git ;;
   ubuntu*)  sudo apt-get install git  ;;
   mint*)    sudo apt-get install git ;;
   zorin*)   sudo apt-get install git ;;
   *)        echo "unknown distro: '$distro' skipping update, you may need to install git yourself" ; ukwn= 1 ;;
esac
sudo apt-get install git
if test "ukwn" = "0"
then
    rm -rf /home/$USER/cmdup
    git clone https://github.com/Gousaid67/steam-cmd-installer /home/$USER/cmdup
fi

cmp -s $0 /home/$USER/cmdup/steamcmdinstaller3.9.sh > /dev/null
if [ $? -eq 1 ]; then
 
 echo -a updating....
 mkdir /home/$USER/oldsh
 mv $0 /home/$USER/oldsh
 rm steamcmdinstaller3.9.sh
 mv /home/$USER/cmdup/steamcmdinstaller3.9.sh /home/$USER/
 chmod +x steamcmdinstaller3.9.sh
 ./steamcmdinstaller3.9.sh
else
    rm -rf /home/$USER/cmdup
    
    echo you are up to date
fi

function getInput()
{
  local rez=""
  echo ------- $1 -------
  read -r rez
  while [ -z "$rez" ]; do
    echo ------ Please put $2 ------
    read -r rez
  done
  eval "$3=$rez"
}
clear
echo --------- do you wish install steamcmd and a server or update/backup your server? instal or maint ------------
select mai in "Maintenance" "Install"; do
    case $mai in
        Maintenance ) mai=1
                     break ;;
        Install ) mai=0
                      break ;;
    esac
done
if test "$mai" == "1"
then
 
 rm -rf servermaintenance.sh
 mv  /home/$USER/cmdup/servermaintenance.sh /home/$USER/
 chmod +x servermaintenance.sh
 rm -rf home/$USER/cmdup
  clear
 
 ./servermaintenance.sh
 exit
fi

echo ------------ This script installs SteamCMD dedicated servers ------------

echo ------- Do you want to install dependencies ? [y or n] -------

read -r bool
if test "$bool" = "y"
then
  archit=$(uname -m)
  echo ------- You are using $archit linux kernel -------
  if [[ "$archit" == "x86_64" ]]; then
   case "$distro" in
     debian*)  sudo dpkg --add-architecture i386 ; sudo apt-get update ; sudo apt-get install lib32gcc1 ; sudo apt-get install lib32stdc++6   ;;
     centos*)  sudo yum check-update ; sudo yum makecache ; sudo yum install lib32gcc1 ; sudo yum install lib32stdc++6 ;;
     ubuntu*)  sudo dpkg --add-architecture i386 ; sudo apt-get update ; sudo apt-get install lib32gcc1 ; sudo apt-get install lib32stdc++6  ;;
     mint*)    sudo dpkg --add-architecture i386 ; sudo apt-get update ; sudo apt-get install lib32gcc1 ; sudo apt-get install lib32stdc++6  ;;
   zorin*) sudo dpkg --add-architecture i386 ; sudo apt-get update ; sudo apt-get install lib32gcc1 ; sudo apt-get install lib32stdc++6  ;;
     *)  echo "unknown distro: '$distro' skipping dependencies, you will have to install those package manually: lib32gcc1 lib32stdc++6 and the architecture i386(32-bits) if not installed" ;;
   esac

  else
   case "$distro" in
   debian*)   sudo apt-get install lib32gcc1  ;;
   centos*)   sudo yum install lib32gcc1 ;;
   ubuntu*)  sudo apt-get install lib32gcc1  ;;
   mint*)     sudo apt-get install lib32gcc1  ;;
   zorin*)   sudo apt-get install lib32gcc1  ;;
   *)        echo "unknown distro: '$distro' skipping update, you will need to install those package manually:lib32gcc1 " ; ukwn= 1 ;;
  esac
   
  fi
fi

if [ -n "$insdir" ]; then
  echo ------- Making directory /steamcmd at $insdir -------
else
  echo ------- Making directory /steamcmd at /home/$USER -------
  insdir="/home/$USER"
fi

# Making a directory and switching into it
mkdir $insdir/steamcmd
cd $insdir/steamcmd

echo ------- Downloading steam -------
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz



tar -xvzf steamcmd_linux.tar.gz

# Make it executable
if [[ -x "$file" ]]
then
  echo steamcmd.sh is executable
else
 echo $file is not executable or not found,checking if it exist at the $insdir/steamcmd
 if [ -f "$file" ]
 then
  echo file found giving it permission
  chmod +x steamcmd.sh
 else
  echo File not found, do you wish to redownload steamcmd? y or n
  read -r redown
  while [ -z "$redown" ]; do
   echo ------ Please give an awnser ------
   read -r redown
  done
  if test "$redown" == "y"
  then
   echo ------- Downloading steam -------
   wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz

    if [[ -x "$file" ]]
    then
     echo --------steamcmd.sh is executable----------
    else
     chmod +x steamcmd.sh
    fi
   fi
  fi
 fi
echo ------- Do you wish to install a game now ? [y or n] -------
read -r bool
   
if test "$bool" == "y"
then
  getInput "Enter a user for steam, or login as anonymous" "user name" user
else
  echo ------- Running steam update check -------
  ./steamcmd.sh +quit
  exit 0
fi

if test "$user" == "anonymous"
then
  getInput "Which appid you wish to install ?" "appid" appid
  if test "$appid" == "90"
  then # https://developer.valvesoftware.com/wiki/Dedicated_Servers_List
    echo "Do you need to install a mod for HL1 / CS1.6 ? [no or <mod_name>]"
    select appmod in "HL1" "CS1.6" "no"; do
    case $appmod in
        CS1.6 ) appmod=CS1.6
                     break ;;
        HL1 ) appmod=HL1
                      break ;;
        no ) appmod=no
                      break ;;
     esac
    done
  fi
  getInput "Where in [$insdir] do you want to put it ?" "path" dir
  mkdir $insdir/$dir
  if test "$appmod" == "no"
  then
    ./steamcmd.sh +login $user +force_install_dir $insdir/$dir +app_update $appid validate +quit
  else
    ./steamcmd.sh +login $user +force_install_dir $insdir/$dir +app_update $appid validate +app_set_config "90 mod $appmod" +quit
  fi
else
  getInput "What is the password for the user [$user] ?" "password" pass
  getInput "Which appid you wish to install ?" "appid" appid
  if test "$appid" == "90"
  then # https://developer.valvesoftware.com/wiki/Dedicated_Servers_List
    echo "Do you need to install a mod for HL1 / CS1.6 ? [no or <mod_name>]" "a mod" appmod
    select appmod in "HL1" "CS1.6" "no"; do
    case $appmod in
        CS1.6 ) appmod=CS1.6
                     break ;;
        HL1 ) appmod=HL1
                      break ;;
        no ) appmod=no
                      break ;;
     esac
    done
  fi
  getInput "Where in [$insdir] do you want to put it ?" "path" dir
  mkdir $insdir/$dir
  if test "$appmod" == "no"
  then
    rm -rf /home/$USER/cmdup
    ./steamcmd.sh +login $user $pass +force_install_dir $insdir/$dir +app_update $appid validate +quit
  else
    rm -rf /home/$USER/cmdup
    ./steamcmd.sh +login $user $pass +force_install_dir $insdir/$dir +app_update $appid validate +app_set_config "90 mod $appmod" +quit
  fi
fi

exit 0
