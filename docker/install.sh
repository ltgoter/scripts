#!/bin/bash
set -x


#install docker
apt-get update

apt-get install -y \
 apt-transport-https \
 ca-certificates \
 curl \
 gnupg-agent \
 software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

apt-cache madison docker-ce

apt-get update
apt-get install -y docker-ce=17.06.0~ce-0~ubuntu