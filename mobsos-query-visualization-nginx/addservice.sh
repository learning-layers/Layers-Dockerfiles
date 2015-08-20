#!/bin/bash

echo "Adding MobSOS QVS to Adapter backend service list"
# docker-compose mbsqvs.yml
# docker cp /abs/path/to/conf/fileordir adapter-externals:/abs/path/to/nginx/services/
docker kill --signal="HUP" adapter 
