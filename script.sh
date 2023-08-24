#!/bin/bash

sleep 30

sudo apt-get install updates



# DOCKER

# Update the apt package index and install packages to allow apt to use a repository over HTTPS:

sudo apt-get update 
sudo apt-get install ca-certificates curl gnupg 


# Add Docker's official GPG key:

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg


# Setup the repository

echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# Update the apt package index:

sudo apt-get update


# install Docker engine, containerd, and Docker Compose

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#__________________________________________________________________________________________________________________________________________________

#KUBERENETES (minikube)


# Installs the latest minikube stable release on x86-64 Linux using binary download:

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube



#__________________________________________________________________________________________________________________________________________________