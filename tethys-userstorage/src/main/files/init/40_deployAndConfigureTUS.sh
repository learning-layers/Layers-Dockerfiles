#!/bin/bash

# add ENV variables to /opt/tomcat/webapps/Tethys-UserStorage/src/main/resources/*.properties
echo "Processing $0"
echo "Deploying and Configurating Tethys-UserStorage..."

# deploy and delete .war
cd ${TOMCAT_HOME}/webapps
mkdir ${TUS}
jar -xf ${TUS_WAR}
rm ${TUS_WAR}
cp -R ${TOMCAT_HOME}/webapps/WEB-INF ${TUS}/

export STORAGE_TYPE=${STORAGE_TYPE:=LocalStorage}
export AUTH_TYPE=${AUTH_TYPE:=MockOIDC}
# configure properties files
cat > ${TUS}/WEB-INF/classes/config.properties << EOF
storageType=${STORAGE_TYPE}
authType=${AUTH_TYPE}
oidcURL=${ADAPTER_URL_OIDC}
authToken=${TUS_PASS}
adminToken=${TUS_PASS}
EOF

cat > ${TUS}/WEB-INF/classes/openstack.properties << EOF
swiftURL=${ADAPTER_URL_SWIFT}
swiftTenantName=${SWIFT_TENANT}
swiftUserName=${SWIFT_USER}
swiftKey=${SWIFT_KEY}
EOF

cat > ${TUS}/WEB-INF/classes/swagger.properties << EOF
swaggerWebApplicationName=TethysUserStorage
swaggerWebApplicationHost=$(hostname --ip-address)
swaggerWebApplicationPort=8080
EOF

echo ""
