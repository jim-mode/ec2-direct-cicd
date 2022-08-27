#!/bin/bash

DOCKER_EXISTS=$(which docker | wc -l)

if [[ ${DOCKER_EXISTS} -eq 1 ]] ; then
  echo "$(date): Docker Exists"
  echo $(docker --version)
else
  echo "$(date): No Docker Found. Installing"
  sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release
  sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update && apt-cache madison docker-ce
  sudo apt-get install -y docker-ce=5:20.10.17~3-0~ubuntu-jammy docker-ce-cli=5:20.10.17~3-0~ubuntu-jammy containerd.io docker-compose-plugin
  sudo usermod -aG docker $USER
  echo "$(date): Docker Install Complete"
fi
