#!/bin/bash

set -e

mkdir -p mysql
docker-compose stop
bash ./setup_databases.sh

docker-compose up -d --x-smart-recreate
docker-compose logs
