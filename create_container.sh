#!/bin/sh

echo "Enter your GitHub email: "
read email

docker pull ubuntu:20.04

mkdir -p $HOME/Documents/ubuntu_docker 

docker run -it -d --name ubuntu-docker --hostname ubuntu-docker \
	-v $HOME/Documents/ubuntu_docker:/root/Documents/shared \
	-e DEBIAN_FRONTEND=noninteractive \
	-p 4244:22 -p 8080:80 ubuntu:20.04


docker exec -it ubuntu-docker apt -y update
docker exec -it ubuntu-docker apt -y upgrade

docker exec -it ubuntu-docker apt install -y zsh gcc git nginx php-fpm build-essential

docker exec -it ubuntu-docker chsh -s /usr/bin/zsh

docker exec -it ubuntu-docker ssh-keygen -t rsa -C $email -f "/root/.ssh/id_rsa_github"
docker exec -it ubuntu-docker sh -c 'echo "Host github.com\n\tHostName github.com\n\tUser git\n\tIdentityFile ~/.ssh/id_rsa_github" > /root/.ssh/config'
docker exec -it ubuntu-docker cat /root/.ssh/id_rsa_github.pub

# docker exec -it ubuntu-docker sh -c "sed -i 's/#cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/7.4/fpm/php.ini"
