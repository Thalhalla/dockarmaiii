FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>, James S. Moore <james@ohmydocker.com>

USER root
ENV DOCKARMAIII_UPDATED 2015121201

EXPOSE 2302
EXPOSE 2303
EXPOSE 2304
EXPOSE 2305
EXPOSE 2344
EXPOSE 2345

# override these variables in your Dockerfile
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GUARD_CODE ' '
# and override this file with the command to start your server
USER root
ADD ./run.sh /run.sh
RUN chmod 755 /run.sh
# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
RUN gpasswd -a steam tty

USER steam
RUN echo 'new-session' >> ~/.tmux.conf
# Create the directories used to store the profile files and Arma3.cfg file
RUN mkdir -p "~/.local/share/Arma 3"
RUN mkdir -p "~/.local/share/Arma 3 - Other Profiles"
# RUN rm -Rf /home/steam/steamcmd
WORKDIR /home/steam
RUN wget http://gameservermanagers.com/dl/arma3server
RUN chmod +x arma3server
### install wasteland
### WORKDIR /home/steam/steamcmd/arma3
### RUN curl -SsL -o mpmissions/A3Wasteland_v1.0b.Altis.pbo https://github.com/crosbymichael/Release_Files/raw/master/A3Wasteland_v1.0b.Altis.pbo

ENTRYPOINT ["/start.sh"]
