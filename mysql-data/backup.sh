#!/bin/bash
echo "MySQL Backup"
# TIME=`date -Iseconds | sed -e "s/[-:]//g"` &&
TIME=$(date +%Y-%m-%d-%H)
echo "Backup start time: $TIME" &&

tar czf /backup/mysql-backup-${TIME}.tar.xz /var/lib/mysql/
ln -sf mysql-backup-${TIME}.tar.xz /backup/mysql-backup.tar.xz
chmod 777 /backup/mysql-backup.tar.xz

REPOSITORY=/backup/mysql.attic
LATEST=$(date +%Y-%m-%d-%H:%M:%S)
attic init $REPOSITORY
attic create --stats "$REPOSITORY::$LATEST" /var/lib/mysql
echo $LATEST > /backup/mysql.attic.latest
attic prune -v $REPOSITORY --keep-hourly=24 --keep-daily=30 --keep-weekly=4 --keep-monthly=12
