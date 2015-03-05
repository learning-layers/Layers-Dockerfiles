#!/bin/bash

# A simple script to start a Layers Box as set of docker containers
# Author: Dominik Renzel, RWTH Aachen University

# set variables to be forwarded as environment variables to docker containers
LAYERS_API_URI="http://localhost/";
LAYERS_APP_URI="http://localhost/";
MYSQL_ROOT_PASSWORD="pass";

echo "Layers API URL: $LAYERS_API_URI";
echo "Layers App URL: $LAYERS_APP_URI";

# Define alias for docker run including all environment variables that must be available to containers.
# TODO: think about solution of not exposing mysql root password to all containers
alias drenv='docker run -e "LAYERS_API_URI=$LAYERS_API_URI" -e "LAYERS_APP_URI=$LAYERS_APP_URI"';

# Clean up: remove all docker containers first to avoid conflicts
# IMPORTANT: make sure data volume containers stay there!

docker stop adapter mysql mobsos-surveys;
docker rm $(docker ps -a -q);
echo "Removed all containers" &&

# start Layers Storage mysql data volume container
drenv -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --name mysql-data learninglayers/mysql-data &&
echo "Started Layers Common Data Storage mysql data volume container" &&

# start Layers Storage mysql container
drenv -d -p 3306:3306 -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --volumes-from mysql-data --name mysql learninglayers/mysql &&
echo "Started Layers Common Data Storage mysql database server" &&

# start Layers Adapter data volume container
drenv --name adapter-data learninglayers/adapter-data &&
echo "Started Layers Adapter data volume" &&

# start Layers Adapter
drenv -d -p 80:80 --volumes-from adapter-data --name adapter learninglayers/adapter &&
echo "Started Layers Adapter" &&

# create MobSOS Surveys user & database
MS_DB="mobsos_surveys" && # MobSOS Monitor database
MS_USER="mobsos_surveys" && # MobSOS Monitor database user
MS_PASS="123456" &&
#MS_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $MM_DB --new-user $MM_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` && # MobSOS Monitor database password (auto-generated)
MS_OIDC_CLIENT_ID="asdasd-234sf-2343-23423"
# start MobSOS Surveys data volume
drenv -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" -e "MS_DB=$MS_DB" -e "MS_OIDC_CLIENT_ID=$MS_OIDC_CLIENT_ID" --name mobsos-surveys-data nmaster/mobsos-surveys-data &&
echo "Started MobSOS Surveys data volume"

# start MobSOS Surveys
#drenv -d -e "MS_PASS=$MS_PASS" -e "MS_USER=$MM_USER" -e "MS_DB=$MM_DB" --link mysql:mysql --volumes-from --volumes-from mobsos-surveys-data --name mobsos-surveys nmaster/mobsos-surveys &&
#echo "Started MobSOS Surveys";

docker run -it --volumes-from mobsos-surveys-data learninglayers/base bash
# TODO: add missing containers