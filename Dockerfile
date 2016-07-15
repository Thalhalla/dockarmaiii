FROM debian:jessie
MAINTAINER Josh Cox <josh 'at' webhosting coop>

#APT
RUN echo 'deb http://http.debian.net/debian/ jessie main contrib non-free'>>/etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN apt-get install -y sudo wget lib32stdc++6 lib32z1 lib32z1-dev net-tools bsdmainutils tmux mailutils postfix ca-certificates lib32gcc1 libstdc++6:i386
RUN rm -rf /var/lib/apt/lists/*

ENV STEAMER_UPDATED 20151104

# override these variables in with the prompts
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '

# and override this file with the script to install your server
COPY ./steamer.txt /home/steam/steamer.txt
RUN chmod 755 /home/steam/steamer.txt

# and override this file with the command to start your server
COPY ./run.sh /run.sh
RUN chmod 755 /run.sh

COPY ./start.sh /start.sh
RUN chmod 755 /start.sh

RUN useradd -m -s /bin/bash steam
RUN usermod -a -G video,audio steam
RUN mkdir -p /home/steam/steamcmd
RUN chown -R steam. /home/steam

USER steam
WORKDIR /home/steam/steamcmd

ADD https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz ./

ENTRYPOINT ["/start.sh"]
