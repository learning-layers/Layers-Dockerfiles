FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

ENV OWNCLOUD_VERSION="owncloud_8.1.0.orig" \
	OWNCLOUD_HOME="/opt/owncloud" \
	DBNAME="pass" \
	DBUSER="pass" \
	DBPASS="pass" \
	DBHOST="localhost" \
	ADMINLOGIN="pass" \
	ADMINPASS="pass" 

RUN apt-get update -q && apt-get install -yq php5 php5-cgi php5-common php5-gd php5-cli php5-fpm php-apc php5-mysql php5-curl openssl nginx tar \ 
	mysql-server vim # TODO: MAKE THE IMAGE WORK WITHOUT THIS LINE

ADD src/main/files/owncloud.sites	/etc/nginx/sites-enabled/owncloud.sites
ADD src/main/files/nginx.conf		/etc/nginx/
ADD src/main/files/php5-fpm.www.conf	/etc/php5/fpm/pool.d/www.conf
ADD src/main/files/init.sh		/opt/init.sh

ADD http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/${OWNCLOUD_VERSION}.tar.gz /opt/
RUN tar -xvzf /opt/${OWNCLOUD_VERSION}.tar.gz -C /opt/ \
	&& chown www-data:www-data -R ${OWNCLOUD_HOME} \
	&& chmod 777 /opt/init.sh \
	&& rm -f /etc/nginx/sites-enabled/default

EXPOSE 80
EXPOSE 443

CMD /opt/init.sh
