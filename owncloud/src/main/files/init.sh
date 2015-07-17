#!/bin/bash

cat > ${OWNCLOUD_HOME}/config/autoconfig.php << EOF
<?php
\$AUTOCONFIG = array(
  'dbtype'        => 'mysql',
  'dbname'        => '${DBNAME}',
  'dbuser'        => '${DBUSER}',
  'dbpass'        => '${DBPASS}',
  'dbhost'        => '${DBHOST}',
  'dbtableprefix' => '',
  'adminlogin'    => '${ADMINLOGIN}',
  'adminpass'     => '${ADMINPASS}',
  'directory'     => '${OWNCLOUD_HOME}/data',
);
EOF

service mysql start

echo "Configurating Database"

mysql -e "CREATE USER '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}'"
mysql -e "CREATE DATABASE IF NOT EXISTS ${DBNAME}"
mysql -D mysql -e "UPDATE user SET password=PASSWORD('root') WHERE User='${DBPASS}'"
mysql -e "FLUSH PRIVILEGES"
mysql -e "GRANT ALL PRIVILEGES ON ${DBNAME}.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}'"


echo "Starting php5-fpm & nginx"

service php5-fpm start && nginx
