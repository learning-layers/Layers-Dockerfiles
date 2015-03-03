rm -R -f /var/www/owncloud
wget https://download.owncloud.org/community/owncloud-8.0.0.tar.bz2 
mkdir -p /var/www 
tar -xvf owncloud-8.0.0.tar.bz2 -C /var/www/ 
chown www-data:www-data -R /var/www/owncloud 
rm owncloud-8.0.0.tar.bz2
