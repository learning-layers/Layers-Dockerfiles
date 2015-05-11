#!/bin/bash

# add ENV variables to /opt/tomcat/webapps/Tethys-UserStorage/src/main/resources/*.properties
echo "Processing $0"
echo "Configurating Tethys-UserStorage..."

# deploy and delete .war
cd ${TOMCAT_HOME}/webapps
mkdir ${TUS}
jar -xv ${TUS_WAR}
rm ${TUS_WAR}
cp -R ${TOMCAT_HOME}/webapps/WEB-INF ${TUS}/

# TODO CONFIGURE!

echo ""
