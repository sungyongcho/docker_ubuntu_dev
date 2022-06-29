#!/bin/sh

docker pull ubuntu:20.04

docker run -it -d --name ubuntu-docker --hostname ubuntu-docker \
	-v /Users/$USER/Documents/ubuntu_docker:/root/Documents/shared \
	-e DEBIAN_FRONTEND=noninteractive \
	-p 4242:22 ubuntu:20.04


docker exec -it ubuntu-docker apt -y update
docker exec -it ubuntu-docker apt -y upgrade

docker exec -it ubuntu-docker apt install -y systemd zsh gcc git

docker exec -it ubuntu-docker chsh -s /usr/bin/zsh

