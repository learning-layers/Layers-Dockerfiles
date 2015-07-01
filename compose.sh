#!/bin/bash

set -e

touch secret.env
docker-compose stop
bash ./setup_databases.sh

docker-compose up -d --x-smart-recreate
docker-compose logs
