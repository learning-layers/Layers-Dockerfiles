FROM learninglayers/base

# add all files from conf subfolder to conf data volume 
ADD conf/ /usr/local/openresty/conf/

# take environment variable LAYERS_API_URI and replace in nginx config template
CMD SERVER_NAME=`echo ${LAYERS_API_URI}| grep -oE '://[^/]+/' | cut -c4- | rev | cut -c2- | rev` && \
	echo $SERVER_NAME && \
	sed -i "s/SERVER_NAME/${SERVER_NAME}/g" /usr/local/openresty/conf/nginx.conf

# provide directories conf and logs as volumes
VOLUME ["/usr/local/openresty/conf/","/usr/local/openresty/logs"]
