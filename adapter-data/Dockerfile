FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# add all files from conf subfolder to conf data volume 
ADD conf/ /usr/local/openresty/conf
#ADD logs/ /usr/local/openresty/logs

# provide volumes: openresty config, logs, docker-gen template path
ENV ORDIR /usr/local/openresty
#VOLUME ["$ORDIR/conf","$ORDIR/logs"]
VOLUME ["$ORDIR/conf"]

# take environment variable LAYERS_API_URI and replace in nginx config template
CMD SERVER_NAME=`echo ${LAYERS_API_URI}| grep -oE '://[^/]+/' | cut -c4- | rev | cut -c2- | rev` && \
	sed -i "s/SERVER_NAME/${SERVER_NAME}/g" /usr/local/openresty/conf/nginx.conf

