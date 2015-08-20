#!/bin/bash

echo "Adding MobSOS Monitor to Adapter backend service list"
# docker-compose mbsm.yml
# docker cp /abs/path/to/conf/fileordir adapter-externals:/abs/path/to/nginx/services/
docker kill --signal="HUP" adapter 
