#!/bin/bash
set -e
cd /opt
wget http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Surveys/lastSuccessfulBuild/artifact/*zip*/archive.zip
mkdir -p /opt/mobsos-surveys/
find /opt/mobsos-surveys/ -mindepth 1 -maxdepth 1 -not -name etc -not -name doc | xargs rm -rf
unzip archive.zip
cd archive
rm -rf etc doc
echo "Moving stuff..."
mv ./* /opt/mobsos-surveys
cd ..
rm -rf archive archive.zip
cd /opt/mobsos-surveys
dos2unix bin/start_ServiceAgentGenerator.sh
chmod +x bin/start_ServiceAgentGenerator.sh
MS_SERVICE_CLASS="i5.las2peer.services.mobsos.SurveyService"
mkdir -p etc/startup
bin/start_ServiceAgentGenerator.sh $MS_SERVICE_CLASS $SURVEYS_PASS > etc/startup/agent-service-mobsos-surveys.xml
echo "agent-service-mobsos-surveys.xml;$SURVEYS_PASS" > etc/startup/passphrases.txt
dos2unix bin/start_network.sh
chmod +x bin/start_network.sh
sed -i "s/mobsosrules/$SURVEYS_PASS/g" bin/start_network.sh
while ! ping -c1 mysql &>/dev/null; do sleep 0.2; done
while ! timeout 1 bash -c 'cat < /dev/null > /dev/tcp/mysql/3306' 2>/dev/null; do sleep 0.5; done
echo Testing main database connection
mysql -u$SURVEYS_DB_USER -p$SURVEYS_DB_PASS -hmysql -e "\q" && \
bin/start_network.sh
