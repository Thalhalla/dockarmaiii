FROM debian:jessie
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV STEAMER_UPDATED 20150513
RUN apt-get -y update
RUN apt-get install -y lib32gcc1
RUN rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash steam
RUN usermod -a -G video,audio steam
RUN sudo -i -u steam mkdir ~/steamcmd
RUN sudo -i -u steam cd ~/steamcmd && sudo -i -u steam wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN sudo -i -u steam cd ~/steamcmd && sudo -i -u steam tar zxvf steamcmd_linux.tar.gz

ADD ./steamer.txt /home/steam/steamer.txt
RUN chmod 755 /home/steam/steamer.txt

ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
ENTRYPOINT ["/start.sh"]
