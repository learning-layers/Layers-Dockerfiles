FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

RUN apt-get update -q && apt-get install -yq php5 php5-cgi php5-common php5-gd php5-cli php5-fpm php-apc php5-mysql nginx


ADD src/main/files/owncloud.sites       /etc/nginx/sites-enabled/owncloud.sites
ADD src/main/files/nginx.conf           /etc/nginx/
RUN rm -f                               /etc/nginx/sites-enabled/default
ADD src/main/files/php5-fpm.www.conf    /etc/php5/fpm/pool.d/www.conf
ADD src/main/files/index.php		/var/www/owncloud/index.php

EXPOSE 80

CMD service php5-fpm start && nginx
