FROM joshuacox/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKARMAIII_UPDATED 20150513

# Create the directories used to store the profile files and Arma3.cfg file
RUN sudo -i -u steam mkdir -p "~/.local/share/Arma 3"
RUN sudo -i -u steam mkdir -p "~/.local/share/Arma 3 - Other Profiles"

# Override the default steamer.txt file
#new
ADD ./steamer.txt /home/steam/steamer.txt
RUN chmod 755 /home/steam/steamer.txt

# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
ENTRYPOINT ["/start.sh"]
