FROM learninglayers/base

# add all files from conf subfolder to conf data volume 
ADD conf/ /usr/local/openresty/conf/

# take environment variable LAYERS_API_URL and replace in nginx config template
CMD sed -i "s/SERVER_NAME/${LAYERS_API_URL}/g" /usr/local/openresty/conf/nginx.conf

# provide directories conf and logs as volumes
VOLUME ["/usr/local/openresty/conf/","/usr/local/openresty/logs"]
