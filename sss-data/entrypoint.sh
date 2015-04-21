#!/bin/bash

cd /opt/sss/ && \
unzip sss.package.zip && \ 
cd sss.package/ && \
sed -i "s#SSS_MYSQL_SCHEME#${SSS_MYSQL_SCHEME}#g" ./sss.app/docker.mysql/sss.schema.sql && \
sed -i "s#SSS_MYSQL_HOST#${SSS_MYSQL_HOST}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_PORT#${SSS_MYSQL_PORT}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_USERNAME#${SSS_MYSQL_USERNAME}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_PASSWORD#${SSS_MYSQL_PASSWORD}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_SCHEME#${SSS_MYSQL_SCHEME}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_AUTH_TYPE#${SSS_AUTH_TYPE}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_USER#${SSS_TETHYS_USER}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_PASSWORD#${SSS_TETHYS_PASSWORD}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_LAS_USER#${SSS_TETHYS_LAS_USER}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_LAS_PASSWORD#${SSS_TETHYS_LAS_PASSWORD}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_OIDC_CONF_URI#${SSS_TETHYS_OIDC_CONF_URI}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_OIDC_USER_END_POINT_URI#${SSS_TETHYS_OIDC_USER_END_POINT_URI}#g" ./sss.app/docker.sss/sss.conf.yaml && \
sed -i "s#SSS_HOST#${SSS_HOST}#g" ./sss.rest/docker.rest/sss.adapter.rest.v2.conf.yaml && \
sed -i "s#SSS_PORT#${SSS_PORT}#g" ./sss.rest/docker.rest/sss.adapter.rest.v2.conf.yaml && \
mv ./sss.rest/docker.rest/sss.adapter.rest.v2.conf.yaml /opt/tomcat/conf/ && \
mv ./sss.rest/sss.adapter.rest.v2.war /opt/tomcat/webapps/ && \

exec "$@"