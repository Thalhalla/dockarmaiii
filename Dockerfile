FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKARMAIII_UPDATED 20170104

# override these variables in with the prompts
ENV STEAM_GID 233780

USER root
# and override this file with the command to start your server
COPY assets /assets
RUN chmod 755 /assets/*.sh && \
chmod 755 /assets/steamer.txt && \
chown -R steam. /home/steam && \
chown -R steam. /opt/steamer

USER steam
WORKDIR /opt/steamer
RUN wget -q https://gameservermanagers.com/dl/arma3server && \
chmod +x arma3server
WORKDIR /home/steam

CMD ["/bin/bash",  "/assets/valve-start.sh"]
