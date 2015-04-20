FROM learninglayers/base

RUN mkir $TOMCAT_HOME

ADD sss/ /opt/sss/

CMD sed -i "s#SSS_MYSQL_SCHEME#${SSS_MYSQL_SCHEME}#g" /opt/sss/mysql/sss.schema.sql && \
sed -i "s#SSS_MYSQL_HOST#${SSS_MYSQL_HOST}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_PORT#${SSS_MYSQL_PORT}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_USERNAME#${SSS_MYSQL_USERNAME}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_PASSWORD#${SSS_MYSQL_PASSWORD}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_MYSQL_SCHEME#${SSS_MYSQL_SCHEME}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_AUTH_TYPE#${SSS_AUTH_TYPE}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_USER#${SSS_TETHYS_USER}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_PASSWORD#${SSS_TETHYS_PASSWORD}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_LAS_USER#${SSS_TETHYS_LAS_USER}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_LAS_PASSWORD#${SSS_TETHYS_LAS_PASSWORD}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_OIDC_CONF_URI#${SSS_TETHYS_OIDC_CONF_URI}#g" /opt/sss/sss.conf.yaml && \
sed -i "s#SSS_TETHYS_OIDC_USER_END_POINT_URI#${SSS_TETHYS_OIDC_USER_END_POINT_URI}#g" /opt/sss/sss.conf.yaml &&
sed -i "s#SSS_HOST#${SSS_HOST}#g" /opt/sss/sss.adapter.rest.v2.conf.yaml && \
sed -i "s#SSS_PORT#${SSS_PORT}#g" /opt/sss/sss.adapter.rest.v2.conf.yaml && \
mv /opt/sss/sss.adapter.rest.v2.conf.yaml /usr/local/tomcat/conf/ && \
mv /opt/sss/sss.adapter.rest.v2.war /usr/local/tomcat/webapps/ && \

VOLUME ["/opt/sss/"]