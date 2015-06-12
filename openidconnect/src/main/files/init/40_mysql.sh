#!/bin/sh

echo "The MYSQL pass is $OIDC_MYSQL_PASSWORD and $OIDC_MYSQL_USER"
mysql -u$OIDC_MYSQL_USER -p$OIDC_MYSQL_PASSWORD -hmysql OpenIDConnect < /etc/sql/schema.sql
mysql -u$OIDC_MYSQL_USER -p$OIDC_MYSQL_PASSWORD -hmysql OpenIDConnect < /etc/sql/schema_upgrade.sql
