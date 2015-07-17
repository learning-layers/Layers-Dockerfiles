#!/bin/bash

# add ENV variables to /opt/tomcat/webapps/${APP_NAME}/src/main/resources/*.properties
echo "Processing $0"
echo "Deploying and Configurating ${APP_NAME}..."

# deploy and delete .war
cd ${TOMCAT_HOME}/webapps
mkdir ${APP_DIR}
jar -xf ${APP_WAR}
rm ${APP_WAR}
cp -R ${TOMCAT_HOME}/webapps/WEB-INF ${APP_DIR}/

# configure properties files
cat > ${APP_DIR}/WEB-INF/classes/swagger.properties << EOF
swaggerWebApplicationName=${APP_NAME}
swaggerWebApplicationHost=$(hostname --ip-address)
swaggerWebApplicationPort=8080
EOF

echo ""

