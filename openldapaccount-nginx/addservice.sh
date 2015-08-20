#!/bin/bash

echo "Adding PWM to Adapter backend service list"
# docker-compose pwm.yml
# docker cp /abs/path/to/conf/fileordir adapter-externals:/abs/path/to/nginx/services/
docker kill --signal="HUP" adapter 
