all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker beep

run: steam_username steam_password steam_guard_code builddocker rundocker beep

rundocker:
	@docker run --name=dockarmaiii \
	--cidfile="cid" \
	--env STEAM_USERNAME=`cat steam_username` \
	--env STEAM_PASSWORD=`cat steam_password` \
	--env STEAM_GUARD_CODE=`cat steam_guard_code` \
	-p 2302:2302/udp \
	-p 2303:2303/udp \
	-p 2304:2304/udp \
	-p 2344:2344/tcp \
	-p 2345:2345/tcp \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-t thalhalla/dockarmaiii

builddocker:
	/usr/bin/time -v docker build -t thalhalla/dockarmaiii .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`

rm-steamer:
	rm  steamer.txt

rm-name:
	rm  name

rm-image:
	@docker rm `cat cid`
	@rm cid

cleanfiles:
	rm name
	rm steam_username
	rm steam_password

rm: kill rm-image

clean: cleanfiles rm

enter:
	docker exec -i -t `cat cid` /bin/bash

steam_username:
	@while [ -z "$$STEAM_USERNAME" ]; do \
		read -r -p "Enter the steam username you wish to associate with this DockArmaIII container [STEAM_USERNAME]: " STEAM_USERNAME; echo "$$STEAM_USERNAME">>steam_username; cat steam_username; \
	done ;

steam_guard_code:
	@while [ -z "$$STEAM_GUARD_CODE" ]; do \
		read -r -p "Enter the steam guard code you wish to associate with this DockArmaIII container [STEAM_GUARD_CODE]: " STEAM_GUARD_CODE; echo "$$STEAM_GUARD_CODE">>steam_guard_code; cat steam_guard_code; \
	done ;

steam_password:
	@while [ -z "$$STEAM_PASSWORD" ]; do \
		read -r -p "Enter the steam password you wish to associate with this DockArmaIII container [STEAM_PASSWORD]: " STEAM_PASSWORD; echo "$$STEAM_PASSWORD">>steam_password; cat steam_password; \
	done ;

