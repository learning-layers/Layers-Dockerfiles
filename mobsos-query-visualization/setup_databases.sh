#!/bin/bash

echo Creating databases and generating new passwords for services
while read -u "$fd_num" service; do
    unset SERVICE_PASS SERVICE_USER SERVICE_DB_NAME TMP_SERVICE_DB TMP_SERVICE_USER
    source "${service}.env"
    TEST_SERVICE_PASS=${service}_DB_PASS
    # if [[ -n ${!TEST_SERVICE_PASS} ]]; then
    #     continue
    #     unset SERVICE_PASS SERVICE_USER SERVICE_DB_NAME TMP_SERVICE_DB TMP_SERVICE_USER
    # fi
    echo Service: ${service}
    TMP_SERVICE_USER=${service}_DB_USER
    TMP_SERVICE_DB=${service}_DB_NAME
    SERVICE_DB_USER=${!TMP_SERVICE_USER}
    SERVICE_DB_NAME=${!TMP_SERVICE_DB}
    echo "SERVICE_DB_USER=${SERVICE_DB_USER}" > secret.env
    echo "SERVICE_DB_NAME=${SERVICE_DB_NAME}" >> secret.env
    SERVICE_PASS=$(docker-compose run mysqlCreate | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-)
    sed -i ${service}.env -e "/${service}_DB_PASS/d"
    echo "${service}_DB_PASS=${SERVICE_PASS}" >> ${service}.env
    echo Generated password ${SERVICE_PASS} for service $service
    echo Finished service: ${service}
    unset SERVICE_PASS SERVICE_USER SERVICE_DB_NAME TMP_SERVICE_DB TMP_SERVICE_USER
done {fd_num}<services
echo "" > secret.env
docker-compose stop
