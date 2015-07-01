#!/bin/bash

set -e

wget -q http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Query%20Visualization/lastSuccessfulBuild/artifact/*zip*/archive.zip
mkdir -p /opt/mobsos-query-visualization
find /opt/mobsos-query-visualization/ -mindepth 1 -maxdepth 1 -not -name etc | xargs rm -rf
unzip archive.zip
cd archive
rm -rf etc doc
echo "Moving stuff..."
mv ./* /opt/mobsos-query-visualization
cd ..
rm -rf archive archive.zip
cd /opt/mobsos-query-visualization
echo "Getting here with user '${QVS_DB_USER}' and pass '${QVS_DB_PASS}'"
echo "Configured MobSOS Query Visualization database"
sed -i -e "s#QVS_DB_USER#${QVS_DB_USER}#g" -e "s#QVS2_DB_USER#${QVS2_DB_USER}#g" -e "s#QVS_DB_PASS#${QVS_DB_PASS}#g" -e "s#QVS2_DB_PASS#${QVS2_DB_PASS}#g" /opt/mobsos-query-visualization/etc/i5.las2peer.services.queryVisualization.QueryVisualizationService.properties
dos2unix bin/start_ServiceAgentGenerator.sh
chmod +x bin/start_ServiceAgentGenerator.sh
dos2unix bin/start_network.sh
chmod +x bin/start_network.sh
sed -i "s/someNewPass/qvPass/g" bin/start_network.sh
while ! ping -c1 mysql &>/dev/null; do sleep 0.2; done
while ! timeout 1 bash -c 'cat < /dev/null > /dev/tcp/mysql/3306' 2>/dev/null; do sleep 0.5; done
echo Trying main database
mysql -u$QVS_DB_USER -p$QVS_DB_PASS -hmysql < db.sql
echo Trying secondary database with user $QVS2_DB_USER and pass $QVS2_DB_PASS
mysql -u$QVS2_DB_USER -p$QVS2_DB_PASS -hmysql < mysqlsampledatabase.sql
bin/start_network.sh
