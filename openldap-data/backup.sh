#!/bin/bash
echo "Openldap Backup"
# TIME=`date -Iseconds | sed -e "s/[-:]//g"` &&
TIME=$(date +%Y-%m-%d-%H)
echo "Backup start time: $TIME" &&

tar czf /backup/openldap-backup-${TIME}.tar.xz /usr/local/etc/openldap/
ln -sf openldap-backup-${TIME}.tar.xz /backup/openldap-backup.tar.xz
chmod 777 /backup/openldap-backup.tar.xz

REPOSITORY=/backup/openldap.attic
LATEST=$(date +%Y-%m-%d-%H:%M:%S)
attic init $REPOSITORY
attic create --stats "$REPOSITORY::$LATEST" /usr/local/etc/openldap
echo $LATEST > /backup/openldap.attic.latest
attic prune -v $REPOSITORY --keep-hourly=24 --keep-daily=30 --keep-weekly=4 --keep-monthly=12
