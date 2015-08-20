#!/bin/bash

echo "Adding OIDC to Adapter backend service list"
# docker-compose oidc.yml
# docker cp /abs/path/to/conf/fileordir adapter-externals:/abs/path/to/nginx/services/
docker kill --signal="HUP" adapter 
