#!/bin/bash
echo "MySQL Restore start"

# if [[ -s /backup/mysql-backup.tar.xz ]]; then
#     if [[ -s /var/lib/mysql/mobsos_logs ]]; then
#         if [[ -z $(find /var/lib/mysql/ -newer /backup/mysql-backup.tar.xz) ]]; then
#             rm -rf /var/lib/mysql/*
#             cd /
#             tar xvf /backup/mysql-backup.tar.xz
#         fi
#     else
#         rm -rf /var/lib/mysql/*
#         cd /
#         tar xvf /backup/mysql-backup.tar.xz
#     fi
# else
#     echo "No backup to restore"
# fi

echo "Starting attic restore"
REPOSITORY=/backup/mysql.attic
if [[ -s /backup/mysql.attic.latest ]]; then
    rm -rf /var/lib/mysql/*
    cd /

    LATEST=$(cat /backup/mysql.attic.latest)
    attic extract $REPOSITORY::$LATEST
    echo "Restored attic backup"
else
    echo "No backup to restore"
fi

touch /backup/blub

echo "MySQL Restore finished"
