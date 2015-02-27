#!/bin/bash

# A simple script to start a Layers Box as set of docker containers
# Author: Dominik Renzel, RWTH Aachen University

# set variables to be forwarded as environment variables to docker containers
LAYERS_API_URL="bauabc-api";
LAYERS_APP_URL="bauabc-app";

echo "Layers API URL: $LAYERS_API_URL";
echo "Layers App URL: $LAYERS_APP_URL";

# Define alias for docker run including all environment variables that must be available to containers.
# TODO: think about solution of not exposing mysql root password to all containers
alias drenv='docker run -e "LAYERS_API_URL=$LAYERS_API_URL" -e "LAYERS_APP_URL=$LAYERS_APP_URL" -e "MYSQL_ROOT_PASSWORD=pass"';

# Clean up: remove all docker containers first to avoid conflicts
# IMPORTANT: make sure data volume containers stay there!

docker rm $(docker ps -a -q) &&
echo "Removed all containers" &&

# docker rmi $(docker images -q) &&
# echo "Removed all images" &&

# start Layers Storage mysql data volume container
drenv --name mysql-data learninglayers/mysql-data

# start Layers Storage mysql container
# TODO: remove -p parameter and replace by link
drenv -d -p 3306:3306 --volumes-from mysql-data --name mysql learninglayers/mysql

# start Layers Adapter data volume container
drenv --name adapter-data learninglayers/adapter-data &&
echo "Started adapter data volume container" &&

# start Layers Adapter container
drenv -d -p 80:80 --volumes-from adapter-data --name adapter learninglayers/adapter &&
echo "Started adapter" &&

# TODO: start rest of the containers...