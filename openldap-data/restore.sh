#!/bin/bash
echo "Openldap Restore start"

# if [[ -s /backup/openldap-backup.tar.xz ]]; then
#     rm -rf /usr/local/etc/openldap/*
#     cd /
#     tar xvf /backup/openldap-backup.tar.xz
#     echo "Restored Openldap backup"
# else
#     echo "No backup to restore"
# fi

echo "Starting attic restore"
REPOSITORY=/backup/openldap.attic
LATEST_FILE=/backup/openldap.attic.latest
if [[ -s $LATEST_FILE ]]; then
    rm -rf /usr/local/etc/openldap/*
    cd /

    LATEST=$(cat $LATEST_FILE)
    attic extract $REPOSITORY::$LATEST
    echo "Restored attic backup"
else
    echo "No backup to restore"
fi

sed -i /usr/local/etc/openldap/slapd.conf -e "s/^rootpw.*/rootpw ${LDAP_ROOT_PASSWORD}/g"

echo "Openldap Restore finished"
