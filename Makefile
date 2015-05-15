all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: steamer.tmpl builddocker beep rm-steamer

run: steamer.tmpl builddocker rundocker beep rm-steamer

rundocker:
	@docker run --name=dockarmaiii \
	--cidfile="cid" \
	-v /tmp:/tmp \
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

steamer.tmpl:
	cp steamer.tpl steamer.tmpl
	sed -i s/REPLACEME_USERNAME/`cat steam_username`/ steamer.tmpl
	sed -i s/REPLACEME_PASSWORD/`cat steam_password`/ steamer.tmpl

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

# will skip over this step if the name file is left from previous run 'make clean' to remove
steam_username:
	@while [ -z "$$STEAM_USERNAME" ]; do \
		read -r -p "Enter the steam username you wish to associate with this DockArmaIII container [STEAM_USERNAME]: " STEAM_USERNAME; echo "$$STEAM_USERNAME">>steam_username; cat steam_username; \
	done ;

steam_password:
	@while [ -z "$$STEAM_PASSWORD" ]; do \
		read -r -p "Enter the steam password you wish to associate with this DockArmaIII container [STEAM_PASSWORD]: " STEAM_PASSWORD; echo "$$STEAM_PASSWORD">>steam_password; cat steam_password; \
	done ;

