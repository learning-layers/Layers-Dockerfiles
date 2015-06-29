#!/bin/bash

set -e

docker-compose stop
# bash ./setup_databases.sh

docker-compose up -d --x-smart-recreate
docker-compose logs
