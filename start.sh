#!/bin/bash

# A simple script to start a Layers Box as set of docker containers
# Author: Dominik Renzel, RWTH Aachen University

# set variables to be forwarded as environment variables to docker containers
LAYERS_SCHEME="http";
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
drenv --name mysql-data learninglayers/mysql-data &&
echo "Started Layers Common Data Storage mysql data volume container" &&

# start Layers Storage mysql container
# TODO: remove -p parameter and replace by link
drenv -d -p 3306:3306 --volumes-from mysql-data --name mysql learninglayers/mysql &&
echo "Started Layers Common Data Storage mysql database server" &&
sleep 5;

# create OpenID Connect database
#OIDC_USER="oidc" &&
#OIDC_DB="openidconnect" &&
#OIDC_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -pMYSQL_ROOT_PASSWORD --new-database $OIDC_DB --new-user $OIDC_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | sed -e 's/-p//g'` &&
#echo "Created OpenID Connect database $OIDC_DB with user $OIDC_USER ($OIDC_PASS)" &&

# start Layers Adapter data volume container
drenv --name adapter-data learninglayers/adapter-data &&
echo "Started Layers Adapter data volume" &&

# start Layers Adapter
drenv -d -p 80:80 --volumes-from adapter-data --name adapter learninglayers/adapter &&
echo "Started Layers Adapter" &&

# create MobSOS Monitor user & database

MM_DB="mobsos_monitor" && # MobSOS Monitor database
MM_USER="mobsos_monitor" && # MobSOS Monitor database user
MM_PASS="123456" &&
#MM_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $MM_DB --new-user $MM_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | sed -e 's/-p//g'` && # MobSOS Monitor database password (auto-generated)
MM_IPINFODB_KEY="shitload" # MobSOS Monitor IPInfoDB API key (used for IP geolocation; check http://ipinfodb.com/ip_location_api_json.php to get a free key)

echo "Created MobSOS Monitor database $MM_DB with user $MM_USER ($MM_PASS)" &&

# start MobSOS Monitor data volume
drenv -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" -e "IPINFODB_KEY=$MM_IPINFODB_KEY" --name mobsos-monitor-data nmaster/mobsos-monitor-data &&
echo "Started MobSOS Monitor data volume"

# start MobSOS Monitor
drenv -d -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" --link mysql:mysql --volumes-from adapter-data --volumes-from mobsos-monitor-data --name mobsos-monitor nmaster/mobsos-monitor &&
echo "Started MobSOS Monitor";

# jump into MobSOS Monitor to check if monitoring works
docker logs -f mobsos-monitor

# create MobSOS Surveys user & database
#MS_USER="mobsos_surveys" &&
#MS_DB="mobsos_surveys" &&
#MS_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -ppass --new-database $MS_DB --new-user $MS_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | sed -e 's/-p//g'` &&
#echo "Created MobSOS Surveys database $MS_DB with user $MS_USER ($MS_PASS)";

# start MobSOS Surveys data volume
#drenv -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" -e "MS_DB=$MS_DB" --name mobsos-surveys-data nmaster/mobsos-surveys-data &&
#echo "Started MobSOS Surveys data volume"

#drenv -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" -d --link mysql:mysql --volumes-from adapter-data --name mobsos-surveys nmaster/mobsos-surveys && 
# retrieve IP address of MobSOS Surveys to add
#MS_IP=`docker inspect -f '{{.NetworkSettings.IPAddress}}' mobsos-surveys` &&
#echo "Started MobSOS Surveys at $MS_IP";



# TODO: start rest of the containers...