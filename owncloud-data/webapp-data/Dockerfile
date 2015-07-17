FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

RUN apt-get update -q && apt-get install -yq wget

RUN wget https://download.owncloud.org/community/owncloud-8.0.0.tar.bz2 \
        && mkdir -p /var/www \
        && tar -xvf owncloud-8.0.0.tar.bz2 -C /var/www/ \
        && chown www-data:www-data -R /var/www/owncloud \
        && rm owncloud-8.0.0.tar.bz2

VOLUME ["/var/www/owncloud/"]
