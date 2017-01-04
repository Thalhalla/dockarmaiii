FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKARMAIII_UPDATED 20170103

# override these variables in with the prompts
ENV STEAM_GID 233780

USER root
# and override this file with the command to start your server
COPY assets /assets
RUN chmod 755 /assets/*.sh ; \
chmod 755 /assets/steamer.tx ; \
chown -R steam. /home/steam

#RUN apt-get install -y wget vim procps
USER steam
WORKDIR /home/steam

CMD ["/bin/bash",  "/assets/start.sh"]
