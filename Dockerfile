FROM joshuacox/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKARMAIII_UPDATED 20150513

# Override the default steamer.txt file
ADD ./steamer.txt /home/steam/steamer.txt
RUN chmod 755 /home/steam/steamer.txt

# Override the default start.sh
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
ENTRYPOINT ["/start.sh"]
