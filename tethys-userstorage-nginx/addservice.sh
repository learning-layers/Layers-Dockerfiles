#!/bin/bash

echo "Adding TUS to Adapter backend service list"
# docker-compose tus.yml
# docker cp /abs/path/to/conf/fileordir adapter-externals:/abs/path/to/nginx/services/
docker kill --signal="HUP" adapter 
