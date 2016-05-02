FROM thalhalla/steamer

MAINTAINER Josh Cox <josh 'at' webhosting coop>, James S. Moore <james@ohmydocker.com>

ENV DOCKARMAIII_UPDATED 2016050201

EXPOSE 2302
EXPOSE 2303
EXPOSE 2304
EXPOSE 2305
EXPOSE 2344
EXPOSE 2345

# override these variables in your Dockerfile
#ENV STEAM_USERNAME ' '
#ENV STEAM_PASSWORD ' '
#ENV IP ' '
#ENV TARGET_IP ' '
#ENV SERVER_PASSWORD ' '

# and override this file with the command to start your server
USER root
RUN apt-get update \
    && apt-get -y install curl libcurl3 vim less rsync

#COPY ./start.sh /start.sh
#RUN chmod 755 /start.sh
COPY ./a3update.txt /home/steam/a3update.txt
RUN chmod 644 /home/steam/a3update.txt

WORKDIR /home/steam/steamcmd

RUN tar xvfz steamcmd_linux.tar.gz \
	&& chown -R steam. /home/steam

# ensure steam user is in tty group
RUN gpasswd -a steam tty

# switch to steam user
USER steam

RUN /home/steam/steamcmd/steamcmd.sh \
        +runscript /home/steam/a3update.txt

# Default tmux session
# Create the directories used to store the profile files and Arma3.cfg file
WORKDIR /home/steam
RUN echo 'new-session' >> ~/.tmux.conf 
RUN mkdir -p "/home/steam/.local/share/Arma 3" \
    && mkdir -p "/home/steam/.local/share/Arma 3 - Other Profiles"

#ENTRYPOINT ["/start.sh"]
ENTRYPOINT ["/bin/bash"]
