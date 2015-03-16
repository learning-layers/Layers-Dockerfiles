#!/bin/bash

# do a simple data backup for all data volumes
echo "Layers Box - Simple Data Backup" &&
START=`date -Iseconds | sed -e "s/[-:]//g"` &&
echo "Backup start time: $START" &&
echo "" &&

echo "Backing up Layers Common Data Storage MySQL databases volumes..." &&
docker run --volumes-from mysql-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-mysql-data.tar /var/lib/mysql;
echo " -> done" &&
echo "" &&

echo "Backing up Layers Adapter data volumes..."
docker run --volumes-from adapter-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-adapter-data.tar /usr/local/openresty/conf /usr/local/openresty/logs;
echo " -> done" &&
echo "" &&

echo "Backing up Layers MobSOS Monitor data volumes..." &&
docker run --volumes-from mobsos-monitor-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-mobsos-monitor-data.tar /opt/mobsos-monitor/etc /opt/mobsos-monitor/log;
echo " -> done" &&
echo "" &&
 
echo "Removing all containers..." &&
docker rm -f $(docker ps -a -q);
echo " -> done" &&
echo "" && 