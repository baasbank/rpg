#!/bin/bash

set -e
DOCKER_IMAGE=$1
CONTAINER_NAME="hello_world"
# Check for arguments
if [[ $# -lt 1 ]] ; then
    echo '[ERROR] You must supply a Docker Image to pull'
    exit 1
fi
echo "Deploying Hello World to Docker Container"

#Check for running container & stop it before starting a new one
if [ $(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME) = "true" ]; then
    sudo docker stop rpg
fi
echo "Starting Hello World using Docker Image name: $DOCKER_IMAGE"
sudo docker run -d --rm=true -p 8080:80  --name rpg $DOCKER_IMAGE
docker ps -a