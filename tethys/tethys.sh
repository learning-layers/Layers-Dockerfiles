#!/bin/bash

#cd into runtime
cd tethys-userstorage-runtime

#clean dirs before building docker
gradle clean

#build Tethys User Storage
docker build --force-rm=true -t layerstethysus .

#run Tethys User Storage; privileged needed to run tomcat
docker run --privileged=true -it -p 8080:8080 layerstethysus
