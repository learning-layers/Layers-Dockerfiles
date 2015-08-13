#!/bin/bash

echo Creating databases and generating new passwords for services
echo "" > secret.env
TMP_SQLFILE=mysql-create/sqlfile/db.sql
rm -rf $TMP_SQLFILE
unset DOBACKUP
while read -u "$fd_num" servicevar; do
    unset SERVICE_PASS SERVICE_USER SERVICE_DB_NAME TMP_SERVICE_DB TMP_SERVICE_USER
    TMPSERV=($servicevar)
    filename=${TMPSERV[0]}
    source "${filename}"
    DB_DIR=${filename%/*}
    DBS=${#TMPSERV[@]}
    for (( i = 1; i < $DBS; i++ )); do
        service=${TMPSERV[$i]}
        TEST_SERVICE_PASS=${service}_DB_PASS
        TMP_SERVICE_EXISTS=${service}_DB_EXISTS
        if [[ -n ${!TEST_SERVICE_PASS} && -n ${!TMP_SERVICE_EXISTS} ]]; then
            continue
            unset SERVICE_PASS SERVICE_USER SERVICE_DB_NAME TMP_SERVICE_DB TMP_SERVICE_USER
        fi
        DOBACKUP="BACKUP"
        echo Service: ${service}
        TMP_SERVICE_USER=${service}_DB_USER
        TMP_SERVICE_DB=${service}_DB_NAME
        SERVICE_DB_USER=${!TMP_SERVICE_USER}
        SERVICE_DB_NAME=${!TMP_SERVICE_DB}
        SERVICE_DB_EXISTS=${!TMP_SERVICE_EXISTS}
        echo $SERVICE_DB_EXISTS
        # If DB has not been created, use an SQL file from the same directory as the .env file.
        # The file has to be called X.sql when the DB is called X
        if [[ -z "$SERVICE_DB_EXISTS" ]]; then
            echo "Copying ${DB_DIR}/${service}.sql to ${TMP_SQLFILE}"
            cp ${DB_DIR}/${service}.sql ${TMP_SQLFILE}
        else
            echo "DB exists"
        fi
        echo "SERVICE_DB_USER=${SERVICE_DB_USER}" > secret.env
        echo "SERVICE_DB_NAME=${SERVICE_DB_NAME}" >> secret.env
        echo "SERVICE_DB_EXISTS=${SERVICE_DB_EXISTS}" >> secret.env
        rm -f ./mysql-data/backup/mysql.attic.latest ./mysql-data/backup/mysql-backup.tar.xz
        CREATE_OUTPUT="$(docker-compose run mysqlcreate)"
        echo "$CREATE_OUTPUT"
        SERVICE_PASS=$(echo "$CREATE_OUTPUT" | grep "mysql" | awk '{split($0,a," "); print a[3]}' | cut -c3-)
        # rm -rf $TMP_SQLFILE
        sed -i ${filename} -e "/${service}_DB_PASS/d" -e "/${service}_DB_EXISTS/d"
        echo "${service}_DB_PASS=${SERVICE_PASS}" >> ${filename}
        echo "${service}_DB_EXISTS=1" >> ${filename}
        echo Generated password ${SERVICE_PASS} for service $service
        echo Finished service: ${service}
        # read blablablabla
        unset SERVICE_PASS SERVICE_USER SERVICE_DB_NAME TMP_SERVICE_DB TMP_SERVICE_USER
    done
done {fd_num}<databases
if [[ -n ${DOBACKUP} ]]; then
    ./backup.sh
fi
echo "" > secret.env
echo " " > $TMP_SQLFILE
