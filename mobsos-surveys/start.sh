#!/bin/bash

# A simple script to start a Layers Box as set of docker containers
# Author: Dominik Renzel, RWTH Aachen University
clear && 

echo "== Layers Box Deployment Routine =="
# set variables to be forwarded as environment variables to docker containers
LAYERS_API_URI="http://192.168.53.109/";
LAYERS_APP_URI="http://192.168.53.109/";
MYSQL_ROOT_PASSWORD="pass";

echo "Layers API URL: $LAYERS_API_URI";
echo "Layers App URL: $LAYERS_APP_URI";

# Define alias for docker run including all environment variables that must be available to containers.
# TODO: think about solution of not exposing mysql root password to all containers
alias drenv='docker run -e "LAYERS_API_URI=$LAYERS_API_URI" -e "LAYERS_APP_URI=$LAYERS_APP_URI"';

# Clean up: remove all docker containers first to avoid conflicts
# IMPORTANT: make sure data volume containers stay there!

docker stop adapter mysql mobsos-surveys-frontend mobsos-surveys; 
docker rm $(docker ps -a -q);
echo "Removed all containers" &&

# start Layers Storage mysql data volume container
drenv -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --name mysql-data learninglayers/mysql-data &&
echo "Started Layers Common Data Storage mysql data volume container" &&

# start Layers Storage mysql container
drenv -d -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --volumes-from mysql-data --name mysql learninglayers/mysql &&
echo "Started Layers Common Data Storage mysql database server" &&

# start Layers Adapter data volume container
drenv --name adapter-data learninglayers/adapter-data &&
echo "Started Layers Adapter data volume" &&

# start Layers Adapter and expose port 80
drenv -d -p 80:80 --volumes-from adapter-data --name adapter learninglayers/adapter &&
echo "Started Layers Adapter" &&

# start MobSOS Surveys frontend static content server
docker run -d --name mobsos-surveys-frontend learninglayers/mobsos-surveys-frontend &&
echo "Started MobSOS Surveys frontend static content server" &&

echo "Please register MobSOS Surveys as OpenID Connect Client and enter client ID:" &&
#read MS_OIDC_CLIENT_ID &&
MS_OIDC_CLIENT_ID="12345-67890" &&

# create MobSOS Surveys user & database
MS_DB="mobsos_surveys" && # MobSOS Monitor database
MS_USER="mobsos_surveys" && # MobSOS Monitor database user
MS_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $MS_DB --new-user $MS_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` && # MobSOS Surveys database password (auto-generated)

# start MobSOS Surveys data volume
drenv -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" -e "MS_DB=$MS_DB" -e "MS_OIDC_CLIENT_ID=$MS_OIDC_CLIENT_ID" --name mobsos-surveys-data nmaster/mobsos-surveys-data &&
echo "Started MobSOS Surveys data volume"

# start MobSOS Surveys
drenv -d -p 8082:8080 -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --link mysql:mysql --volumes-from mobsos-surveys-data --name mobsos-surveys nmaster/mobsos-surveys &&
echo "Started MobSOS Surveys" &&

# list all internal IP addresses of services to be added to Layers Adapter configuration
MS_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} mobsos-surveys` &&
MSF_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} mobsos-surveys-frontend` &&
echo "Please add proxy pass directives for the following services in the Layers Adapter configuration: \n" &&

echo "$MS_IP - MobSOS Surveys" &&
echo "$MSF_IP - MobSOS Surveys (frontend static content server)" &&

# if container starts as daemon, but terminates, inspect console output.
docker logs -f mobsos-surveys 

# if container runs through, exec into it.
# docker exec -it mobsos-surveys bash
# exec into adapter container to manually add services to configuration /usr/local/openresty/conf/nginx.conf
#docker exec -it adapter /bin/bash -c 'vi /usr/local/openresty/conf/nginx.conf && /usr/local/openresty/nginx/sbin/nginx -s reload && echo "Layers Adapter configuration updated successfully"'