#!/bin/sh

# Waiting for mysql server to become ready
while ! ping -c1 mysql &>/dev/null; do sleep 0.2; done
while ! timeout 1 bash -c 'cat < /dev/null > /dev/tcp/mysql/3306' 2>/dev/null; do sleep 0.5; done

echo "The MYSQL pass is $OIDC_DB_PASS and $OIDC_DB_USER"
mysql -u$OIDC_DB_USER -p$OIDC_DB_PASS -hmysql $OIDC_DB_NAME < /etc/sql/schema.sql

while ! ping -c1 ldap &>/dev/null; do sleep 0.2; done
while ! timeout 1 bash -c 'cat < /dev/null > /dev/tcp/ldap/389' 2>/dev/null; do sleep 0.5; done
