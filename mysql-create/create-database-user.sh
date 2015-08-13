#!/bin/bash

if [ -z ${SERVICE_DB_USER+x} ]; then
    echo No SERVICE_DB_USER set, exiting…
    exit 0
fi

if [ -z ${SERVICE_DB_NAME+x} ]; then
    echo No SERVICE_DB_NAME set, exiting…
    exit 0
fi

SERVICE_PASSWORD=$(pwgen -1sB 32)

while ! ping -c1 mysql &>/dev/null; do sleep 0.2; done
while ! timeout 1 bash -c 'cat < /dev/null > /dev/tcp/mysql/3306' 2>/dev/null; do sleep 0.5; done

echo SERVICE_DB_USER is $SERVICE_DB_USER
echo SERVICE_DB_NAME is $SERVICE_DB_NAME

# if [ -z  "$(mysql -h mysql -s -p${SERVICE_PASSWORD} -u ${SERVICE_DB_USER} -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = ${SERVICE_DB_NAME}")" ]
# then
    # create database
mysql -p${MYSQL_ROOT_PASSWORD} -h mysql -Bse "CREATE DATABASE IF NOT EXISTS ${SERVICE_DB_NAME}; grant all on ${SERVICE_DB_NAME}.* to '${SERVICE_DB_USER}'@'%' identified by '${SERVICE_PASSWORD}';"
# fi

echo "You can now connect to the MySQL container from linked containers by using:"
echo "mysql -u${SERVICE_DB_USER} -p$SERVICE_PASSWORD -hmysql"

if [[ -z "$SERVICE_DB_EXISTS" ]]; then
    echo DB did not exist, importing sql file…
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -hmysql < /sqlfile/db.sql
fi

