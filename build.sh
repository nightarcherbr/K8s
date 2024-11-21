#!/bin/bash
VERSION=$(date +"%Y%U")'.'$(expr $(date +"%s") % 10000)

echo "Construindo imagem WEBPHP:${VERSION}";
docker build -t webphp:$VERSION -t webphp:latest images/webphp;
docker build -t git:$VERSION -t git:latest images/git;


read -p "Upload to Minikube? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    minikube image load webphp:$VERSION webphp:latest
fi
echo "Done"

docker image ls;
# minikube image ls;
