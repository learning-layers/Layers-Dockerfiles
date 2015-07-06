#/bin/bash
rm -rf archive.zip archive/
wget -q http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Query%20Visualization/lastSuccessfulBuild/artifact/*zip*/archive.zip
unzip -q archive.zip
rm -rf archive.zip
mv archive/db.sql ./QVS.sql
mv archive/mysqlsampledatabase.sql ./QVS2.sql
rm -rf archive/
