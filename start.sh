#!/bin/bash

# A simple script to deploy Layers Box as set of docker containers
# Authors: Dominik Renzel, István Koren, Petru Nicolaescu (RWTH Aachen University)

clear && 
echo "***** Layers Box - Basic Deployment Script *****" &&
echo "" &&

echo "It is mandatory to use BTRFS for the OpenStack Swift component. Checking Docker storage driver: " &&
HOST_FS=$(docker info | grep Storage | awk '{print $3}') &&
if [ HOST_FS==btrfs ]; then
  echo "The host system uses BTRFS. Proceeding with the Layers Box set-up." 
else
  echo "The host system uses a FS different than BTRFS! Ceasing Layers Box deployment." && exit 1
fi  &&
echo "This script will now deploy a Layers Box in a Docker-enabled environment step-by-step. After successful deployment, the Layers Box exposes its APIs and applications under the following URIs:" &&
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
SHIPYARD_ADMIN_PASS="pass"; 
SWIFT_TENANT="tenant"  #"tethysTenant";
SWIFT_USER="user" #"tethysUserStorage";
SWIFT_KEY="key" #"pass";
LDAP_ADMINS="koren;nicolaescu";

# Used for IP geolocation; get API key: http://ipinfodb.com/ip_location_api_json.php";
MM_IPINFODB_KEY="";

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
echo "To clean up the Layers Box host environment, all containers will be removed, including all data containers! Use backup.sh for a simple backup of all Layers Box data volume containers before you continue! (Press enter to continue)" && 
read # Comment interactive step for complete automation
 
echo "Removing all containers..." &&
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

echo "Waiting 4 seconds for MySql to start"
sleep 4

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
docker run -d -p 389:389 -e "LDAP_ROOT_PASSWORD=$LDAP_ROOT_PASSWORD" --volumes-from openldap-data --name openldap learninglayers/openldap &&
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

##updated to support default admin users
#docker run -e "OIDC_MYSQL_USER=$OIDC_MYSQL_USER" -e
#"OIDC_MYSQL_PASSWORD=$OIDC_MYSQL_PASSWORD" -e
#"LAYERS_API_URI=http://192.168.59.103:8080" -e "LDAP_DC=dc=layersbox"
#"LDAP_ADMINS=$LDAP_ADMINS" --name openidconnect-data learninglayers/openidconnect-data

# start OpenID Connect
echo "Starting Layers OpenID Connect provider..." &&
docker run -d -p 8080:8080 -e "OIDC_MYSQL_USER=$OIDC_MYSQL_USER" -e "OIDC_MYSQL_PASSWORD=$OIDC_MYSQL_PASSWORD" --volumes-from openidconnect-data --link mysql:mysql --link openldap:openldap --name openidconnect learninglayers/openidconnect &&
echo " -> done" &&
echo "" &&

##updated to support default admin users
#docker run -d -p 8080:8080 -e "OIDC_MYSQL_USER=$OIDC_MYSQL_USER" -e
#"OIDC_MYSQL_PASSWORD=$OIDC_MYSQL_PASSWORD" -e
#"LAYERS_API_URI=$LAYERS_API_URI" -e "LDAP_DC=dc=layersbox"
#"LDAP_ADMINS=$LDAP_ADMINS" --name openidconnect --link mysql:mysql --link openldap:openldap learninglayers/openidconnect

# start OpenStack Swift
echo "Starting OpenStack Swift..." &&
docker run --name swift -d -p 8082:8080 -e "SWIFT_TENANT=$SWIFT_TENANT" -e "SWIFT_USER=$SWIFT_USER" -e "SWIFT_KEY=$SWIFT_KEY" learninglayers/swift &&
echo " -> done" &&
echo "" &&

# start Tethys User Storage
ADAPTER_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} adapter`
ADAPTER_PORT=`docker inspect -f {{.NetworkSettings.Ports}} adapter | cut -c 55-56`
echo "Starting Tethys user storage..." &&
docker run --name tethys-userstorage -d -p 8081:8080 -e "TUS_PASS=pass" -e "ADAPTER_URL_SWIFT=$ADAPTER_IP:$ADAPTER_PORT/swift" -e "SWIFT_TENANT=$SWIFT_TENANT" -e "SWIFT_USER=$SWIFT_USER" -e "SWIFT_KEY=$SWIFT_KEY" learninglayers/tethys-userstorage  &&
echo " -> done" &&
echo "" &&

# write OpenID Connect's container IP adress to nginx.conf
# write Swift's container IP adress and port to nginx.conf
# write Tethys' container IP adress and port to nginx.conf
OIDC_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} openidconnect` &&
SWIFT_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} swift` &&
TETHYS_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} tethys-userstorage` &&
SUBS="# add oidc location below" &&
SUBS2="# add swift location below" &&
SUBS3="# add tethys location below" &&
OIDC_LOC="location ~ /o/(oauth2|resources) {\n proxy_pass\thttp://$OIDC_IP:8080;\n proxy_redirect\tdefault;\n proxy_set_header\tHost\t\$host;\n}\n" &&
SWIFT_LOC="location ~* /(swift|openstackswift) {\n proxy_pass\thttp://$SWIFT_IP:8082;\n proxy_redirect\tdefault;\n proxy_set_header\tHost\t\$host;\n}\n" &&
TETHYS_LOC="location ~* /(tethys|userstorage) {\n proxy_pass\thttp://$TETHYS_IP:8081;\n proxy_redirect\tdefault;\n proxy_set_header\tHost\t\$host;\n}\n" &&

docker run -d -e "OIDC_LOC=$OIDC_LOC" -e "OIDC_IP=$OIDC_IP" -e "SUBS=$SUBS" --volumes-from adapter-data learninglayers/base bash -c 'sed -i "s%${SUBS}%${OIDC_LOC}%g" /usr/local/openresty/conf/nginx.conf' &&
docker kill --signal="HUP" adapter &&

docker run -d -e "SWIFT_LOC=$SWIFT_LOC" -e "SWIFT_IP=$SWIFT_IP" -e "SUBS2=$SUBS2" --volumes-from adapter-data learninglayers/base bash -c 'sed -i "s%${SUBS2}%${SWIFT_LOC}%g" /usr/local/openresty/conf/nginx.conf' &&
docker kill --signal="HUP" adapter &&

docker run -d -e "TETHYS_LOC=$TETHYS_LOC" -e "TETHYS_IP=$TETHYS_IP" -e "SUBS3=$SUBS3" --volumes-from adapter-data learninglayers/base bash -c 'sed -i "s%${SUBS3}%${TETHYS_LOC}%g" /usr/local/openresty/conf/nginx.conf' &&
docker kill --signal="HUP" adapter &&

# create MobSOS Monitor user & database
echo "Creating MobSOS Monitor user & database..." &&
#MM_PASS="123456" &&
MM_PASS=`drenv --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $MM_DB --new-user $MM_USER | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` && 
echo " -> done" &&
echo "" &&

# start MobSOS Monitor data volume
echo "Starting MobSOS Monitor data volume..." &&
drenv -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" -e "OIDC_MYSQL_DB=$OIDC_MYSQL_DB" -e "IPINFODB_KEY=$MM_IPINFODB_KEY" --name mobsos-monitor-data learninglayers/mobsos-monitor-data &&
echo " -> done" &&
echo "" &&

# start MobSOS Monitor
echo "Starting MobSOS Monitor..." &&
drenv -d -e "MM_PASS=$MM_PASS" -e "MM_USER=$MM_USER" -e "MM_DB=$MM_DB" -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" --link mysql:mysql --volumes-from adapter-data --volumes-from mobsos-monitor-data --name mobsos-monitor learninglayers/mobsos-monitor &&
echo " -> done" &&
echo "" &&

####
##This is the part which will start Shipyard.
#
##TODO:The following needs to be modified; it is possible to run docker with a bind for every command, but editing Docker's config is more flexible
#echo "Starting Shipyard..." &&
#docker -H tcp://0.0.0.0:7890 run --rm -v /var/run/docker.sock:/var/run/docker.sock shipyard/deploy start &&
#
##The CLI should be run in a separate virtual window, otherwise no other instruction past the one below will get executed
##docker -H tcp://0.0.0.0:7890 run -it shipyard/shipyard-cli && shipyard add-engine --id local --addr http://0.0.0.0:7890 --label local
#
##Here, a default preconfiguration is done avoiding the CLI
#echo "Preparing custom configuration..." &&
#echo "Step 1: Logging in Shipyard as admin ..." &&
#
###### The following fails with curl error 56. I suppose some quotes need to be escaped first.
#
#SHIPYARD_ADMIN_AUTH_TOKEN=$(curl -H "content-Type: application/json" -X POST -d '{"username": "admin", "password": "$SHIPYARD_ADMIN_PASS"}' http://localhost:8080/auth/login | jq '.auth_token') &&
#echo "... finished" &&
#
#echo "Step 2: Changing admin password..." &&
#curl -H 'X-Access-Token: admin:$SHIPYARD_ADMIN_AUTH_TOKEN' -X POST -d '{"username": "admin", "password": "$SHIPYARD_ADMIN_PASS", "role": {"name": "admin"}}' http://localhost:8080/api/accounts &&
#echo "... finished" &&
#
#echo "Adding the Layers Box as the default Shipyard Engine..." &&
#curl -H 'X-Access-Token: admin:$SHIPYARD_ADMIN_AUTH_TOKEN' -H 'Content-Type application/json' -X POST -d '{"id":"local", "ssl_cert": "", "ssl_key": "", "ca_cert": "", "engine": {"id": "local", "addr": "http://172.17.42.1:7890", "cpus": 3.0, "memory": 4096, "labels":["local"]}}' http://localhost:8080/api/engines &&
#echo "... finished" &&
#
#echo " -> done" &&
#echo "" &&
####

# TODO: add missing containers
# Tethys -> in progress
# ClViTra
# MobSOS Surveys
# Requirements Bazaar
# LTB APIs
# Tomcat
# Freeradius -> in progress
# TODO: change order of started containers: 1) adapter 2)backend containers not requiring the adapter 3) containers communicating via the adapter 4) update nginx.conf

# start PWM data volume:
echo "Starting Layers OpenLDAP Account data volume..." &&
docker run --name openldapaccount-data learninglayers/openldapaccount-data &&
echo " -> done" &&
echo "" && 

# start PWM
echo "Starting Layers OpenLDAP Account..." &&
drenv --name openldapaccount -d -p 8083:8080 --volumes-from openldapaccount-data --link openldap:openldap -e "LDAP_DC=$LDAP_DC" -e "PWM_LDAP_ADMINS=$PWM_LDAP_ADMINS" learninglayers/openldapaccount &&

# env variables need for SSS
$SSS_MYSQL_SCHEME = "sss";
$SSS_MYSQL_USERNAME = "sss";

# create SSS database and user
#echo "Creating SSS database and user..." &&
#SSS_MYSQL_PASSWORD=`docker run --link mysql:mysql learninglayers/mysql-create -p$MYSQL_ROOT_PASSWORD --new-database $SSS_MYSQL_SCHEME --new-user $SSS_MYSQL_USERNAME | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-` &&
#echo " -> done" &&
#echo "" &&

#echo "starting SSS container ..." &&
#docker run \
#-d \
#-e "MYSQL_ROOT_USERNAME=root" \
#-e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" \
#-e "SSS_HOST=host_with_out_protocol" \
#-e "SSS_PORT=8390" \
#-e "SSS_PORT_FOR_TOMCAT=8391" \
#-e "SSS_MYSQL_HOST=host_with_out_protocol" \
#-e "SSS_MYSQL_PORT=3333" \
#-e "SSS_MYSQL_USERNAME=$SSS_MYSQL_USERNAME" \
#-e "SSS_MYSQL_PASSWORD=$SSS_MYSQL_PASSWORD" \
#-e "SSS_MYSQL_SCHEME=$SSS_MYSQL_SCHEME" \
#-e "SSS_AUTH_TYPE=oidc" \
#-e "SSS_TETHYS_USER=sss_tethys_user" \
#-e "SSS_TETHYS_PASSSWORD=sss_tethys_password" \
#-e "SSS_TETHYS_LAS_USER=sss_las_user" \
#-e "SSS_TETHYS_LAS_PASSWORD=sss_las_password" \
#-e "SSS_TETHYS_OIDC_CONF_URI=https://api.learning-layers.eu/o/oauth2/.well-known/openid-configuration" \
#-e "SSS_TETHYS_OIDC_USER_END_POINT_URI=https://api.learning-layers.eu/o/oauth2/userinfo" \
#-p 8391:8390 \
#--link mysql:mysql \
#--volumes-from tomcat \
#--name sss \
#learninglayers/sss &&
#echo "done --> starting SSS container ..."

# register SSS REST API in OIDC
#echo "Registering SSS REST API in OIDC..." &&
#docker run -d -e "OIDC_LOC=$OIDC_LOC" -e "OIDC_IP=$OIDC_IP" -e "SUBS=$SUBS" --volumes-from adapter-data learninglayers/base bash -c 'sed -i "s%${SUBS}%${OIDC_LOC}%g" /usr/local/openresty/conf/nginx.conf' &&
#docker kill --signal="HUP" adapter &&
#echo " -> done" &&
#echo "" &&

echo "Finished... Layers Box up and running." &&
echo "" &&

# now produce info for manual work (for now)

# service container IPs (to be entered into Layers Adapter config)
echo "Service Container IPs: " > deploy.txt &&
OIDC_IP=`docker inspect -f {{.NetworkSettings.IPAddress}} openidconnect` &&
echo " - OpenID Connect Provider: $OIDC_IP" >> deploy.txt &&
echo "" >> deploy.txt &&

# generated passwords (mainly for databases)
echo "Generated Passwords: " >> deploy.txt &&
echo "  OIDC_MYSQL_PASS: $OIDC_MYSQL_PASS" >> deploy.txt &&
echo "  MM_PASS: $MM_PASS" >> deploy.txt

