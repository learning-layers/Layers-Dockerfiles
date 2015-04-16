This folder contains the Dockerfile for the data volume used by docker-gen

Run this container as follows: 
docker run -d --volumes-from --name CONTAINER_NAME NAME_OF_DOCKER_GET_DATA_VOLUME_CONTAINER --volumes-from NAME_OF_ADAPTER_DATA_VOLUME_CONTAINER -t learninglayers/docker-gen-data -notify-sighup NAME_OF_ADAPTER_DATA_VOLUME_CONTAINER  -watch --only-published /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf
