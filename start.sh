#!/bin/bash

# A simple script to deploy Layers Box as set of docker containers
# Authors: Dominik Renzel, István Koren, Petru Nicolaescu (RWTH Aachen University)

clear && 
echo "***** Layers Box - Basic Deployment Script *****" &&
echo "" &&
echo "This script will deploy a Layers Box in a Docker-enabled environment step-by-step. After successful deployment, the Layers Box exposes its APIs and applications under the following URIs:" &&
echo && 

# set variables to be forwarded as environment variables to docker containers
LAYERS_API_URI="http://192.168.59.103/";
LAYERS_APP_URI="http://192.168.59.103/";

# block of environment variables set to Docker containers
# use for configuration of Layers Box
MYSQL_ROOT_PASSWORD="pass";
LDAP_ROOT_PASSWORD="pass";
OIDC_MYSQL_DB="OpenIDConnect";
OIDC_MYSQL_USER="oidc";
MM_DB="mobsos_logs";
MM_USER="mobsos_monitor"; 

# Please enter MobSOS Monitor IPInfoDB API key (used for IP geolocation; check http://ipinfodb.com/ip_location_api_json.php to get a free key)";
MM_IPINFODB_KEY="12345-67890";

# Define alias for docker run including all environment variables that must be available to containers.
alias drenv='docker run -e "LAYERS_API_URI=$LAYERS_API_URI" -e "LAYERS_APP_URI=$LAYERS_APP_URI"';

echo ""
echo "Layers API URI: $LAYERS_API_URI";
echo "Layers App URI: $LAYERS_APP_URI";
echo ""

# Clean up: remove all docker containers first to avoid conflicts
echo "****************" &&
echo "** WARNING!!! **" &&
echo "****************" &&
echo "" &&
echo "To clean up the Layers Box host environment, all containers will be removed, including all data containers! Backup data before you continue! (Press enter to continue)" && 
read # Comment interactive step for complete automation

echo "Removing all containers..." &
docker rm -f $(docker ps -a -q);
echo " -> done" &&
echo "" && 

# start Layers Storage mysql data volume container
echo "Starting Layers Common Data Storage MySQL data volume container..." &&
drenv -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --name mysql-data learninglayers/mysql-data &&
echo " -> done" &&
echo "" && 

# start Layers Storage mysql container
echo "Starting Layers Common Data Storage MySQL database server..." &&
drenv -d -p 3306:3306 -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --volumes-from mysql-data --name mysql learninglayers/mysql &&
echo " -> done" &&
echo "" && 

# start Layers Adapter data volume container
echo "Starting Layers Adapter data volume..." &&
drenv --name adapter-data learninglayers/adapter-data &&
echo " -> done" &&
echo "" && 

# start Layers Adapter
echo "Starting Layers Adapter..." &&
drenv -d -p 80:80 --volumes-from adapter-data --name adapter learninglayers/adapter &&
echo " -> done" &&
echo "" && 

# start Layers OpenLDAP data volume
echo "Starting Layers OpenLDAP data volume..." &&
docker run -e "LDAP_ROOT_PASSWORD=$LDAP_ROOT_PASSWORD" --name openldap-data learninglayers/openldap-data &&
echo " -> done" &&
echo "" && 

# start Layers OpenLDAP
echo "Starting Layers OpenLDAP..." &&
docker run -d -p 389:389 -e "LDAP_ROOT_PASSWORD=pass" --volumes-from openldap-data --name openldap learninglayers/openldap &&
echo " -> done" &&
echo "" && 

# create OpenID Connect database and user
echo "Creating OpenID Connect database and user..." &&
OIDC_MYSQL_PASSWORD=`docker run --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $OIDC_MYSQL_DB --new-user $OIDC_MYSQL_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` &&
echo " -> done" &&
echo "" &&

# start OpenID Connect data volume (TODO: switch to DockerHub)
echo "Starting Layers OpenID Connect data volume..." &&
docker run -e "OIDC_MYSQL_USER=$OIDC_MYSQL_USER" -e "OIDC_MYSQL_PASSWORD=$OIDC_MYSQL_PASSWORD" -e "LAYERS_API_URI=$LAYERS_API_URI" -e "LDAP_DC=dc=layersbox" --name openidconnect-data learninglayers/openidconnect-data &&
echo " -> done" &&
echo "" && 

# start OpenID Connect
echo "Starting Layers OpenID Connect provider..." &&
docker run -d -p 8080:8080 -e "OIDC_MYSQL_USER=$OIDC_MYSQL_USER" -e "OIDC_MYSQL_PASSWORD=$OIDC_MYSQL_PASSWORD" --volumes-from openidconnect-data --link mysql:mysql --link openldap:openldap --name openidconnect learninglayers/openidconnect &&
echo " -> done" &&
echo "" && 

# create MobSOS Monitor user & database
echo "Creating MobSOS Monitor user & database..." &&
MM_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $MM_DB --new-user $MM_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` && 
echo " -> done" &&
echo "" &&

# start MobSOS Monitor data volume
echo "Starting MobSOS Monitor data volume..." &&
drenv -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" -e "IPINFODB_KEY=$MM_IPINFODB_KEY" --name mobsos-monitor-data learninglayers/mobsos-monitor-data &&
echo " -> done" &&
echo "" &&

# start MobSOS Monitor
echo "Starting MobSOS Monitor..." &&
drenv -d -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --link mysql:mysql --volumes-from adapter-data --volumes-from mobsos-monitor-data --name mobsos-monitor learninglayers/mobsos-monitor &&
echo " -> done" &&
echo "" &&

# TODO: add missing containers

echo "Finished... Layers Box up and running." &&
echo "" &&

# now display info for manual work (for now)

# service container IPs (to be entered into Layers Adapter config)
echo "Service Container IPs: " &&
OIDC_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} openidconnect` &&
echo " - OpenID Connect Provider: $OIDC_IP" &&
echo "" &&

# generated passwords (mainly for databases)
echo "Generated Passwords: " &&
echo "  OIDC_MYSQL_PASS: $OIDC_MYSQL_PASS" &&
echo "  MM_PASS: $MM_PASS";

