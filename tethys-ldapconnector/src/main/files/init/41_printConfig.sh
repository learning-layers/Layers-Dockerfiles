!/bin/bash

# add properties files to /opt/tomcat/webapps/APP_NAME/src/main/resources/*.properties
echo "Processing $0"
echo "Printing ${APP_NAME} properties files:"
echo ""

# Print every properties file in ${TETHYS_US}/WEB-INF/classes
for CONFIG in ${APP_DIR}/WEB-INF/classes/*.properties
do
        echo "   File ${CONFIG}: "
        cat ${CONFIG}
        echo ""
done

echo ""

