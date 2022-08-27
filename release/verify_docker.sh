#!/bin/bash

DOCKER_EXISTS=$(which docker | wc -l)

if [[ ${DOCKER_EXISTS} -eq 1 ]] ; then
  echo "$(date): Docker found"
  echo $(docker --version)
else
  echo "$(date): No docker found. Installing"
  sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release
  sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update && apt-cache madison docker-ce
  sudo apt-get install -y docker-ce=5:20.10.17~3-0~ubuntu-jammy docker-ce-cli=5:20.10.17~3-0~ubuntu-jammy containerd.io docker-compose-plugin
  sudo usermod -aG docker $USER
  echo "$(date): Docker install complete"
fi

DOCKER_COMPOSE_EXISTS=$(which docker-compose | wc -l)

if [[ ${DOCKER_COMPOSE_EXISTS} -eq 1 ]] ; then
  echo "$(date): docker-compose found"
  echo $(docker-compose --version)
else
  echo "$(date): No docker-compose found. Installing"
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  echo $(docker-compose --version)
  echo "$(date): docker-compos install complete"
fi
