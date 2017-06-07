FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKARMAIII_UPDATED 20170104

# override these variables in with the prompts
ENV STEAM_GID 233780
ENV CLIENT_IP  10.42.227.21
ENV CLIENT_IP2 10.42.227.22
ENV CLIENT_IP3 10.42.227.23
ENV CLIENT_IP4 10.42.227.24
ENV CLIENT_IP5 10.42.227.25
ENV CLIENT_IP6 10.42.227.26

USER root

RUN apt-get update && apt-get install -y sudo less vim && \
# remove git and tmp dirs
  apt-get remove -y git cmake linux-headers-amd64 build-essential libssl-dev libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev libcurl4-openssl-dev libusb-dev zlib1g-dev libudev-dev && \
     apt-get autoremove -y && \
     apt-get clean && \
     rm -rf /var/lib/apt/lists/*


# and override this file with the command to start your server
COPY assets /assets
RUN chmod 755 /assets/*.sh && \
chmod 755 /assets/*.cfg && \
chmod 755 /assets/steamer.txt && \
chown -R steam. /home/steam && \
chmod +x /assets/arma3server && \
cp /assets/arma3server /opt/steamer/ && \
chown -R steam. /opt/steamer

USER steam
WORKDIR /opt/steamer
# RUN wget -q https://gameservermanagers.com/dl/arma3server
WORKDIR /home/steam

CMD ["/bin/bash",  "/assets/valve-start.sh"]
