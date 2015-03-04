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

docker stop adapter mysql mobsos-monitor;
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

# create MobSOS Monitor user & database

MM_DB="mobsos_logs" && # MobSOS Monitor database
MM_USER="mobsos_monitor" && # MobSOS Monitor database user
MM_PASS="123456" &&
#MM_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $MM_DB --new-user $MM_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` && # MobSOS Monitor database password (auto-generated)
MM_IPINFODB_KEY="apikey" && # MobSOS Monitor IPInfoDB API key (used for IP geolocation; check http://ipinfodb.com/ip_location_api_json.php to get a free key)

# start MobSOS Monitor data volume
drenv -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" -e "IPINFODB_KEY=$MM_IPINFODB_KEY" --name mobsos-monitor-data learninglayers/mobsos-monitor-data &&
echo "Started MobSOS Monitor data volume"

# start MobSOS Monitor
drenv -d -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --link mysql:mysql --volumes-from adapter-data --volumes-from mobsos-monitor-data --name mobsos-monitor learninglayers/mobsos-monitor &&
echo "Started MobSOS Monitor";

# TODO: add missing containers