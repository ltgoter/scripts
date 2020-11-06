#!/bin/bash
set -x

./install.sh


mkdir /mnt2 && /usr/local/etc/emulab/mkextrafs.pl /mnt2

cd ~

# git clone https://github.com/ltstriker/scripts.git

# cd scripts/docker

# chmod +x *.sh

# ./install

systemctl stop docker

mkdir -p /mnt2/dockerdata

cp -r /var/lib/docker /mnt2/dockerdata

mkdir -p /etc/systemd/system/docker.service.d/
echo "[Service]
ExecStart=
ExecStart=/usr/bin/dockerd  --graph=/mnt2/dockerdata" >  /etc/systemd/system/docker.service.d/devicemapper.conf



systemctl daemon-reload
systemctl restart docker
systemctl enable docker