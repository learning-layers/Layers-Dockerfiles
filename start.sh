#!/bin/bash

set -e

mkdir -p mysql
touch secret.env
docker-compose stop -t 5 && sudo systemctl stop 'docker-*.scope'
./backup.sh

docker rm -f -v $(docker ps -a -f name=layersdockerfiles_ -q)
bash ./setup_databases.sh

docker-compose stop -t 5 && sudo systemctl stop 'docker-*.scope'
docker-compose up -d --x-smart-recreate
docker-compose logs
