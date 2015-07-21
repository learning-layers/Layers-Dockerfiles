#!/bin/bash

set -e

mkdir -p mysql
touch secret.env
docker-compose stop -t 5
./backup.sh

docker rm -f -v $(docker ps -a -f name=layersdockerfiles_ -q)
bash ./setup_databases.sh

docker-compose stop -t 5
docker-compose up -d --x-smart-recreate
docker-compose logs
