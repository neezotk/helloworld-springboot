#!/bin/bash


set -e  # Stop on error

#message erreur indiquant quel stage a echoué
trap 'echo "❌ Erreur à létape : $CURRENT_STEP"; exit 1' ERR



#Variables
GIT_REPO="https://github.com/neezotk/helloworld-springboot.git"
APP_NAME="helloworld-springboot"
PORT=9090
DOCKER_USER="neezo"
DOCKER_IMAGE="$DOCKER_USER/$APP_NAME"
TAG=$(date +%Y%m%d%H%M)


#recuperation Dockerfile via le depot GIT
CURRENT_STEP="récuperation Dockerfile"
echo "$CURRENT_STEP ..."
git clone $GIT_REPO
cd $APP_NAME

#Build Docker APP
CURRENT_STEP="Build Docker APP"
echo "$CURRENT_STEP ..."
docker build -t $DOCKER_IMAGE:$TAG .


#Lancement Containeur basee sur le Dockerfile
CURRENT_STEP="Lancement Containeur basee sur le Dockerfile"
echo "$CURRENT_STEP ..."
docker run --name $APP_NAME -d -p $PORT:8080 $DOCKER_IMAGE:$TAG
sleep 20

#Test de l'app
CURRENT_STEP="Test de l'app"
echo "$CURRENT_STEP ..."
curl http://localhost:$PORT | grep -q "Hello World"

#push image dockerhub

CURRENT_STEP="push image dockerhub"
echo "$CURRENT_STEP ..."
docker push "$DOCKER_IMAGE:$TAG"

#nettoyage environnement travail
CURRENT_STEP="nettoyage environnement travail"
echo "$CURRENT_STEP ..."
cd
docker rm -f $APP_NAME
rm -rf helloworld-springboot


#fin du script
echo "🎉 Tout s’est bien passé !" 








