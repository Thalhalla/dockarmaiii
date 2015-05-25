FROM joshuacox/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKARMAIII_UPDATED 20150525

ENV STEAMER_UPDATED 20150513
# override these variables in your Dockerfile
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
# and override this file with the command to start your server
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh
# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# install wasteland
USER steam
# Create the directories used to store the profile files and Arma3.cfg file
RUN mkdir -p "~/.local/share/Arma 3"
RUN mkdir -p "~/.local/share/Arma 3 - Other Profiles"
WORKDIR /home/steam
RUN wget http://gameservermanagers.com/dl/arma3server
RUN chmod +x arma3server
# WORKDIR /home/steam/steamcmd/arma3
# RUN curl -SsL -o mpmissions/A3Wasteland_v1.0b.Altis.pbo https://github.com/crosbymichael/Release_Files/raw/master/A3Wasteland_v1.0b.Altis.pbo

ENTRYPOINT ["/start.sh"]
