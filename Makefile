.PHONY: run build homedir
all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker beep

run: builddocker rm TAG HOMEDIR homedir rundocker beep

install: builddocker rm TAG HOMEDIR homedir installdocker

rundocker: STEAM_USERNAME STEAM_GID STEAM_PASSWORD STEAM_GUARD_CODE TAG HOMEDIR
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	$(eval NAME := $(shell cat NAME))	
	$(eval HOMEDIR := $(shell cat HOMEDIR))	
	$(eval TAG := $(shell cat TAG))
	$(eval STEAM_USERNAME := $(shell cat STEAM_USERNAME))
	$(eval STEAM_PASSWORD := $(shell cat STEAM_PASSWORD))
	$(eval STEAM_GID := $(shell cat STEAM_GID))
	chmod 777 $(TMP)
	@docker run --name=steamer \
	-d \
	-P \
	--net=host \
	--cidfile="steamerCID" \
	--env USER=steam \
	--env STEAM_USERNAME=$(STEAM_USERNAME) \
	--env STEAM_PASSWORD=$(STEAM_PASSWORD) \
	--env STEAM_GID=$(STEAM_GID) \
	--env STEAM_GUARD_CODE=$(STEAM_GUARD_CODE) \
	-v $(TMP):/tmp \
	-v $(HOMEDIR)/.steam:/home/steam/.local \
	-v $(HOMEDIR)/.local:/home/steam/.steam \
	-v $(HOMEDIR)/SteamLibrary:/home/steam/SteamLibrary \
	-v $(HOMEDIR)/Steam:/home/steam/Steam \
	-t $(TAG)

installdocker: STEAM_USERNAME STEAM_GID STEAM_PASSWORD STEAM_GUARD_CODE TAG HOMEDIR
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	$(eval NAME := $(shell cat NAME))	
	$(eval HOMEDIR := $(shell cat HOMEDIR))	
	$(eval TAG := $(shell cat TAG))
	$(eval STEAM_USERNAME := $(shell cat STEAM_USERNAME))
	$(eval STEAM_PASSWORD := $(shell cat STEAM_PASSWORD))
	$(eval STEAM_GID := $(shell cat STEAM_GID))
	chmod 777 $(TMP)
	@docker run --name=steamer \
	-d \
	--cidfile="steamerCID" \
	--env USER=steam \
	--env STEAM_USERNAME=$(STEAM_USERNAME) \
	--env STEAM_PASSWORD=$(STEAM_PASSWORD) \
	--env STEAM_GID=$(STEAM_GID) \
	--env STEAM_GUARD_CODE=$(STEAM_GUARD_CODE) \
	-v $(TMP):/tmp \
	-v $(HOMEDIR)/.steam:/home/steam/.local \
	-v $(HOMEDIR)/.local:/home/steam/.steam \
	-v $(HOMEDIR)/SteamLibrary:/home/steam/SteamLibrary \
	-v $(HOMEDIR)/Steam:/home/steam/Steam \
	-v $(HOMEDIR)/Steam:/home/steam/steamcmd \
	-t $(TAG) /bin/bash

builddocker:
	$(eval TAG := $(shell cat TAG))
	/usr/bin/time -v docker build -t $(TAG) .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	-@docker kill `cat steamerCID`

rm-image:
	-@docker rm `cat steamerCID`
	-@rm steamerCID

rm: kill rm-image

clean:  rm

logs:
	docker logs  -f `cat steamerCID`

enter:
	docker exec -i -t `cat steamerCID` /bin/bash

TAG:
	@while [ -z "$$TAG" ]; do \
		read -r -p "Enter the TAG you wish to associate with this container [TAG]: " TAG; echo "$$TAG">>TAG; cat TAG; \
	done ;

HOMEDIR:
	@while [ -z "$$HOMEDIR" ]; do \
		read -r -p "Enter the HOMEDIR you wish to associate with this container [HOMEDIR]: " HOMEDIR; echo "$$HOMEDIR">>HOMEDIR; cat HOMEDIR; \
	done ;

STEAM_USERNAME:
	@while [ -z "$$STEAM_USERNAME" ]; do \
		read -r -p "Enter the steam username you wish to associate with this container [STEAM_USERNAME]: " STEAM_USERNAME; echo "$$STEAM_USERNAME">>STEAM_USERNAME; cat STEAM_USERNAME; \
	done ;

STEAM_GUARD_CODE:
	@while [ -z "$$STEAM_GUARD_CODE" ]; do \
		read -r -p "Enter the steam guard code you wish to associate with this container [STEAM_GUARD_CODE]: " STEAM_GUARD_CODE; echo "$$STEAM_GUARD_CODE">>STEAM_GUARD_CODE; cat STEAM_GUARD_CODE; \
	done ;

STEAM_GID:
	@while [ -z "$$STEAM_GID" ]; do \
		read -r -p "Enter the steam password you wish to associate with this container [STEAM_GID]: " STEAM_GID; echo "$$STEAM_GID">>STEAM_GID; cat STEAM_GID; \
	done ;

STEAM_PASSWORD:
	@while [ -z "$$STEAM_PASSWORD" ]; do \
		read -r -p "Enter the steam password you wish to associate with this container [STEAM_PASSWORD]: " STEAM_PASSWORD; echo "$$STEAM_PASSWORD">>STEAM_PASSWORD; cat STEAM_PASSWORD; \
	done ;

homedir: HOMEDIR
	$(eval HOMEDIR := $(shell cat HOMEDIR))	
	-@sudo mkdir -p $(HOMEDIR)/SteamLibrary/steamapps
	-@sudo mkdir -p $(HOMEDIR)/Steam
	-@sudo mkdir -p $(HOMEDIR)/steamcmd
	-@sudo mkdir -p $(HOMEDIR)/.steam
	-@sudo mkdir -p $(HOMEDIR)/.local
	-@sudo chown -R 1000:1000 $(HOMEDIR)
