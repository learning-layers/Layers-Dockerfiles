#!/bin/bash

touch secret.env
docker-compose stop -t 5
./backup.sh
docker-compose stop -t 5
docker rm -f -v $(docker ps -a -f name=layersdockerfiles_ -q)
