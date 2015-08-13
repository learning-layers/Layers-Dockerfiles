#!/bin/bash

docker-compose stop
docker rm $(docker ps -a -f name=mobsosqueryvisualization_ -q)
