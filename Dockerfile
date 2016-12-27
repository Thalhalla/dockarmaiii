FROM thalhalla/steamer
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV DOCKARMAIII_UPDATED 20161226

# override these variables in with the prompts
ENV STEAM_USERNAME anonymous
ENV STEAM_PASSWORD ' '
ENV STEAM_GID 27710

USER root
# and override this file with the command to start your server
COPY assets /assets
RUN chmod 755 /assets/start.sh ; \
chmod 755 /assets/run.sh ; \
chmod 755 /assets/steamer.txt

USER steam

CMD ["/bin/bash",  "/assets/start.sh"]
