#/bin/bash
rm -rf archive.zip archive/
wget -q http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Monitor/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
unzip -q archive.zip
rm -rf archive.zip
mv archive/etc/sql/schema.sql ./MM.sql
rm -rf archive/
