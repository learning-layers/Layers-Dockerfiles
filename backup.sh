#!/bin/bash

bla='layersdockerfiles'

docker run -v $(pwd)/mysql-data/backup/:/backup    --volumes-from ${bla}_mysqldata_1    gordinlearninglayers/backup /backup-scripts/backup.sh
docker run -v $(pwd)/openldap-data/backup/:/backup --volumes-from ${bla}_openldapdata_1 gordinlearninglayers/backup /backup-scripts/backup.sh

exit

# do a simple data backup for all data volumes
echo "Layers Box - Simple Data Backup" &&
START=`date -Iseconds | sed -e "s/[-:]//g"` &&
echo "Backup start time: $START" &&
echo "" &&

echo "Backing up Layers Common Data Storage MySQL databases volumes..." &&
docker exec mysql mysqldump -uroot -pbYLTCgtNgSk7EMcqzhSLx5FftcQpnmQV --all-databases > /opt/mysqlbackup/MySQLDump`date -Idate`.sql
#docker run --volumes-from mysql-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-mysql-data.tar /var/lib/mysql;
echo " -> done" &&
echo "" &&

#echo "Backing up Layers Adapter data volumes..."
#docker run --volumes-from adapter-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-adapter-data.tar /usr/local/openresty/conf /usr/local/openresty/logs;
#echo " -> done" &&
#echo "" &&

echo "Backing up Layers OpenLDAP data volumes..."
docker exec openldap slapcat -f slapd.conf -b dc=learning-layers,dc=eu > /opt/openldapbackup/LDAPDump`date -Idate`.ldif
#docker run --volumes-from openldap-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-openldap-data.tar /usr/local/etc/openldap;
echo " -> done" &&
echo ""

#echo "Backing up Layers OpenID Connect data volumes..."
#docker run --volumes-from openidconnect-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-openidconnect-data.tar /etc/mitreid-connect /etc/sql;
#echo " -> done" &&
#echo "" &&

#echo "Backing up Layers OpenLDAP Account data volumes..."
#docker run --volumes-from openldapaccount-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-openldapaccount-data.tar /opt/conf /opt/account;
#echo " -> done" &&
#echo "" &&


#echo "Backing up Layers MobSOS Monitor data volumes..." &&
#docker run --volumes-from mobsos-monitor-data -v $(pwd):/backup learninglayers/base tar cvf ./backup/${START}-backup-mobsos-monitor-data.tar /opt/mobsos-monitor/etc /opt/mobsos-monitor/log;
#echo " -> done" &&
#echo ""
