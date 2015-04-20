#!/bin/bash

cd /opt/sss/

mysql -uroot -p$MYSQL_ROOT_PASSWORD -hmysql < sss.schema.sql

java -jar -Dlog4j.configuration=file:log4j.properties sss.jar

read

exec "$@"