FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV LANG en_US.UTF-8 

ENV DOCKARMAIII_UPDATED 20161228

# override these variables in with the prompts
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GID 233780

USER root
# and override this file with the command to start your server
COPY assets /assets
RUN chmod 755 /assets/start.sh ; \
chmod 755 /assets/run.sh ; \
chmod 755 /assets/lgsm.sh ; \
chmod 755 /assets/steamer.txt

#RUN apt-get install -y wget vim procps
USER steam
WORKDIR /home/steam
RUN wget https://gameservermanagers.com/dl/arma3server; chmod +x arma3server

CMD ["/bin/bash",  "/assets/start.sh"]
