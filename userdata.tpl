#!/bin/bash
set -e


apt-get update -y
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release


mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg


DISTRO=$(lsb_release -cs)


echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $DISTRO stable" \
> /etc/apt/sources.list.d/docker.list


apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io


usermod -aG docker ubuntu


systemctl enable docker
systemctl start docker


echo "Docker instalado com sucesso" >> /var/log/user-data.log
