#!/bin/sh

docker pull ubuntu:20.04

docker run -it -d --name ubuntu-docker --hostname ubuntu-docker \
	-v /Users/$USER/Documents/ubuntu_docker:/root/Documents/shared \
	-e DEBIAN_FRONTEND=noninteractive \
	-p 4242:22 ubuntu:20.04


docker exec -it ubuntu-docker apt -y update
docker exec -it ubuntu-docker apt -y upgrade

docker exec -it ubuntu-docker apt install -y zsh gcc git

docker exec -it ubuntu-docker chsh -s /usr/bin/zsh

docker exec -it ubuntu-docker ssh-keygen -t rsa -C "to.sungyongcho@gmail.com" -f "/root/.ssh/id_rsa_github"
docker exec -it ubuntu-docker sh -c 'echo "Host github.com\n\tHostName github.com\n\tUser git\n\tIdentityFile ~/.ssh/id_rsa_github" > /root/.ssh/config'
docker exec -it ubuntu-docker cat /root/.ssh/id_rsa_github.pub
