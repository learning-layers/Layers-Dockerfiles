CREATE USER ''@'localhost' IDENTIFIED BY '77hdhY4avT';
CREATE DATABASE IF NOT EXISTS owncloud;
GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'localhost' IDENTIFIED BY '77hdhY4avT';
USE mysql; 
UPDATE user SET password=PASSWORD('root') WHERE User='0KmF5zArK5'; 
FLUSH PRIVILEGES;
