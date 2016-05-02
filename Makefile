.PHONY: all help build run builddocker rundocker kill rm-image rm clean enter logs

user = $(shell whoami)
ifeq ($(user),root)
$(error  "do not run as root! run 'gpasswd -a USER docker' on the user of your choice")
endif

all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container
	@echo ""   2. make build     - build docker container
	@echo ""   3. make clean     - kill and remove docker container
	@echo ""   4. make enter     - execute an interactive bash in docker container
	@echo ""   3. make logs      - follow the logs of docker container

build: NAME TAG STEAM_USERNAME STEAM_PASSWORD IP TARGET_IP SERVER_PASSWORD builddocker

# run a plain container
run: build rundocker

jessie:
	sudo bash local-jessie.sh

## useful hints
## specifiy ports
#-p 44180:80 \
#-p 27005:27005/udp \
## link another container
#--link some-mysql:mysql \
## assign environmant variables
#--env STEAM_USERNAME=`cat steam_username` \
#--env STEAM_PASSWORD=`cat steam_password` \

# change uid in the container for easy dev work
# first you need to determin your user:
# $(eval UID := $(shell id -u))
# then you need to insert this as a env var:
# -e "DOCKER_UID=$(UID)" \
# then look at chguid.sh for an example of 
# what needs to be run in the live container upon startup

rundocker:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	$(eval NAME := $(shell cat NAME))
	$(eval TAG := $(shell cat TAG))
	$(eval STEAM_USERNAME := $(shell cat STEAM_USERNAME))
	$(eval STEAM_PASSWORD := $(shell cat STEAM_PASSWORD))
	$(eval IP := $(shell cat IP))
	$(eval TARGET_IP := $(shell cat TARGET_IP))
	$(eval SERVER_PASSWORD := $(shell cat SERVER_PASSWORD))
	chmod 777 $(TMP)
	@docker run --name=$(NAME) \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	-e TERM=xterm \
	-d \
	-e STEAM_USERNAME=$(STEAM_USERNAME) \
	-e STEAM_PASSWORD=$(STEAM_PASSWORD) \
	-e IP=$(IP) \
	-e TARGET_IP=$(TARGET_IP) \
	-e SERVER_PASSWORD=$(SERVER_PASSWORD) \
	-P \
	--net=host \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	-v /exports/remote_src/PDG/docker_volumes:/home/steam/pdg \
	-t $(TAG)
	# -p 4.31.168.84:2302:2302/udp \
	# -p 4.31.168.84:2303:2303/udp \
	# -p 4.31.168.84:2304:2304/udp \
	# -p 4.31.168.84:2305:2305/udp \
	# -p 4.31.168.84:2302:2302/tcp \
	# -p 4.31.168.84:2303:2303/tcp \
	# -p 4.31.168.84:2304:2304/tcp \
	# -p 4.31.168.84:2305:2305/tcp \
	# -p 4.31.168.84:2344:2344/tcp \
	# -p 4.31.168.84:2345:2345/tcp \


builddocker:
	/usr/bin/time -v docker build -t `cat TAG` .

kill:
	-@docker kill `cat cid`

rm-image:
	-@docker rm `cat cid`
	-@rm cid

rm: kill rm-image

clean: rm

enter:
	docker exec -i -t `cat cid` /bin/bash

logs:
	docker logs -f `cat cid`

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

TAG:
	@while [ -z "$$TAG" ]; do \
		read -r -p "Enter the tag you wish to associate with this container [TAG]: " TAG; echo "$$TAG">>TAG; cat TAG; \
	done ;


# Steam Specific Additions
STEAM_USERNAME:
	@while [ -z "$$STEAM_USERNAME" ]; do \
		read -r -p "Enter the Steam user [STEAM_USERNAME]: " STEAM_USERNAME; echo "$$STEAM_USERNAME">>STEAM_USERNAME; cat STEAM_USERNAME; \
	done ;
STEAM_PASSWORD:
	@while [ -z "$$STEAM_PASSWORD" ]; do \
		read -r -p "Enter the Steam password [STEAM_PASSWORD]: " STEAM_PASSWORD; echo "$$STEAM_PASSWORD">>STEAM_PASSWORD; cat STEAM_PASSWORD; \
	done ;
IP:
	@while [ -z "$$IP" ]; do \
		read -r -p "Enter IP address to assign to this container [IP]: " IP; echo "$$IP">>IP; cat IP; \
	done ;
TARGET_IP:
	@while [ -z "$$TARGET_IP" ]; do \
		read -r -p "Enter IP address of the target Arma3 server [TARGET_IP]: " TARGET_IP; echo "$$TARGET_IP">>TARGET_IP; cat TARGET_IP; \
	done ;
SERVER_PASSWORD:
	@while [ -z "$$SERVER_PASSWORD" ]; do \
		read -r -p "Enter password for the Arma3 server [SERVER_PASSWORD]: " SERVER_PASSWORD; echo "$$SERVER_PASSWORD">>SERVER_PASSWORD; cat SERVER_PASSWORD; \
	done ;
