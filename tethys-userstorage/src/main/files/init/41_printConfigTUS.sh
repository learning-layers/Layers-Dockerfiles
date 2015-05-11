#!/bin/bash

# add ENV variables to /opt/tomcat/webapps/Tethys-UserStorage/src/main/resources/*.properties
echo "Processing $0"
echo "Printing Tethys-UserStorage Configuration:"
echo ""

# Print every properties file in ${TETHYS_US}/WEB-INF/classes
for CONFIG in ${TUS}/WEB-INF/classes/*.properties
do
	echo "   File ${CONFIG}: "
	cat ${CONFIG}
	echo ""
done

echo ""
