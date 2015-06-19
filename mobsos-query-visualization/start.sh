#!/bin/bash

# A simple script to start a Layers Box as set of docker containers
# Author: Dominik Renzel, RWTH Aachen University
clear && 

echo "== Layers Box Deployment Routine =="
# set variables to be forwarded as environment variables to docker containers
LAYERS_API_URI="http://192.168.59.103/";
LAYERS_APP_URI="http://192.168.59.103/";
MYSQL_ROOT_PASSWORD="pass";

echo "Layers API URL: $LAYERS_API_URI";
echo "Layers App URL: $LAYERS_APP_URI";

# Define alias for docker run including all environment variables that must be available to containers.
# TODO: think about solution of not exposing mysql root password to all containers
alias drenv='docker run -e "LAYERS_API_URI=$LAYERS_API_URI" -e "LAYERS_APP_URI=$LAYERS_APP_URI"';

# Clean up: remove all docker containers first to avoid conflicts
# IMPORTANT: make sure data volume containers stay there!

docker stop adapter mysql; 
docker rm -f $(docker ps -a -q);
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

#echo "Please register MobSOS Surveys as OpenID Connect Client and enter client ID:" &&
#read MS_OIDC_CLIENT_ID &&
MS_OIDC_CLIENT_ID="12345-67890" &&

# start MobSOS Query Visualization frontend static content server
docker run -d -e "MS_OIDC_CLIENT_ID=$MS_OIDC_CLIENT_ID" --name mobsos-query-visualization-frontend mqv-frontend &&
echo "Started MobSOS Query Visualization frontend static content server" &&

# create MobSOS Query Visualization user & database
MS_DB="QVS" && # MobSOS query visualization database
MS_USER="mobsos_qv" && # MobSOS query visualization database user
MS_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $MS_DB --new-user $MS_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` && # MobSOS Query Visualization database password (auto-generated)
echo "Created MobSOS Query Visualization database '$MS_DB' with user '$MS_USER' and password '$MS_PASS'" &&

# start MobSOS Query Visualization data volume
drenv -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" -e "MS_DB=$MS_DB" -e "MS_OIDC_CLIENT_ID=$MS_OIDC_CLIENT_ID" --name mobsos-query-visualization-data mqv-data &&
echo "Started MobSOS Quey Visualization data volume" &&

# start MobSOS Query Visualization
#drenv -d -p 8082:8080 -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" --link mysql:mysql --volumes-from mobsos-query-visualization-data --name mobsos-query-visualization mqv &&
drenv -d -v /dev/urandom:/dev/random -p 8082:8080 -e "MS_PASS=$MS_PASS" -e "MS_USER=$MS_USER" --link mysql:mysql --volumes-from mobsos-query-visualization-data --name mobsos-query-visualization mqv &&
echo "Started MobSOS Query Visualization";

# list all internal IP addresses of services to be added to Layers Adapter configuration
export MS_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} mobsos-query-visualization` &&
export MSF_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} mobsos-query-visualization-frontend` &&
echo "Please add proxy pass directives for the following services in the Layers Adapter configuration: \n" &&
echo "$MS_IP - MobSOS Query Visualization - API" &&
echo "$MSF_IP - MobSOS Query Visualization - Frontend" &&

# if container starts as daemon, but terminates, inspect console output.
#docker logs -f mobsos-query-visualization

# if container runs through, exec into it.
#docker exec -it mobsos-query-visualization bash

# proxy_set_header        Host $host;
#      proxy_set_header        X-Real-IP $remote_addr;
#      proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
#      proxy_set_header        X-Forwarded-Proto $scheme;

      # Fix the “It appears that your reverse proxy set up is broken" error.
    #proxy_pass          http://localhost:8080;
    #  proxy_read_timeout  90;

      #proxy_redirect      http://localhost:8080 https://jenkins.domain.com;
	  
# exec into adapter container to manually add services to configuration /usr/local/openresty/conf/nginx.conf
docker exec -it adapter bash -c "sed 's*# add locations below*# add locations below\n\n\tlocation /mobsos-qv/ {\n\t\tproxy_pass http://$MSF_IP:8080/;\n\t}*g' /usr/local/openresty/conf/nginx.conf > tmp && mv tmp /usr/local/openresty/conf/nginx.conf && cat /usr/local/openresty/conf/nginx.conf && /usr/local/openresty/nginx/sbin/nginx -s reload && echo 'Layers Adapter configuration updated successfully'"