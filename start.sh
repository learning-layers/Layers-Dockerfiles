#!/bin/bash

# A simple script to start a Layers Box as set of docker containers
# Author: Dominik Renzel, RWTH Aachen University

# set variables to be forwarded as environment variables to docker containers
LAYERS_API_URL="localhost";
LAYERS_APP_URL="localhost";
MYSQL_ROOT_PASSWORD="pass";

echo "Layers API URL: $LAYERS_API_URL";
echo "Layers App URL: $LAYERS_APP_URL";

# Define alias for docker run including all environment variables that must be available to containers.
# TODO: think about solution of not exposing mysql root password to all containers
alias drenv='docker run -e "LAYERS_API_URL=$LAYERS_API_URL" -e "LAYERS_APP_URL=$LAYERS_APP_URL" -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD"';

# Clean up: remove all docker containers first to avoid conflicts
# IMPORTANT: make sure data volume containers stay there!

docker stop adapter mysql mobsos-monitor &&
docker rm $(docker ps -a -q) &&
echo "Removed all containers" &&

# docker rmi $(docker images -q) &&
# echo "Removed all images" &&

# start Layers Storage mysql data volume container
drenv --name mysql-data learninglayers/mysql-data
echo "Started Layers Common Data Storage mysql data volume container"

# start Layers Storage mysql container
# TODO: remove -p parameter and replace by link
drenv -d -p 3306:3306 --volumes-from mysql-data --name mysql learninglayers/mysql
echo "Started Layers Common Data Storage mysql database server"

# start Layers Adapter data volume container
drenv --name adapter-data learninglayers/adapter-data &&
echo "Started Layers Adapter data volume container" &&

# start Layers Adapter container
drenv -d -p 80:80 --volumes-from adapter-data --name adapter learninglayers/adapter &&
echo "Started Layers Adapter" &&

# create MobSOS Monitor user & database
# TODO: would be nicer to have password directly as output.
MM_USER="mobsos_monitor" &&
MM_DB="mobsos_monitor" &&

MM_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -ppass --new-database $MM_DB --new-user $MM_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | sed -e 's/-p//g'` &&
echo "Created database $MM_DB with user $MM_USER -- $MM_PASS";

# start MobSOS Monitor data volume
drenv -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" --name mobsos-monitor-data nmaster/mobsos-monitor-data &&
echo "Started MobSOS Monitor data volume"

drenv -d --link mysql:mysql --volumes-from adapter-data --name mobsos-monitor nmaster/mobsos-monitor && 
echo "Started MobSOS Monitor";

# retrieve IP address of MobSOS Monitor (not necessary here... just checking)
MM_IP=`docker inspect -f '{{.NetworkSettings.IPAddress}}' mobsos-monitor`;

docker exec -it mobsos-monitor bash

# TODO: start rest of the containers...