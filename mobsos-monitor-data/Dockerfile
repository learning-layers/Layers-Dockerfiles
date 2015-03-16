FROM learninglayers/base

# add files to data volume 
ADD etc /opt/mobsos-monitor/etc

# in MobSOS Monitor config replace API URI (environment variable $LAYERS_API_URI), database user and generated password (environment variables $MM_USER and $MM_PASS), and a valid key for the used IPInfoDB API (environment variable $IPINFODB_KEY).
CMD sed -i "s#LAYERS_API_URI#${LAYERS_API_URI}#g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s#PASSWORD#${MM_PASS}#g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s#USER#${MM_USER}#g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s#DATABASE#${MM_DB}#g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s#IPINFODB_KEY#${IPINFODB_KEY}#g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s#MM_PASS#${MM_PASS}#g" /opt/mobsos-monitor/etc/sql/schema.sql && \
	sed -i "s#MM_USER#${MM_USER}#g" /opt/mobsos-monitor/etc/sql/schema.sql && \
	sed -i "s#MM_DB#${MM_DB}#g" /opt/mobsos-monitor/etc/sql/schema.sql && \
	sed -i "s#OIDC_MYSQL_DB#${OIDC_MYSQL_DB}#g" /opt/mobsos-monitor/etc/sql/schema.sql
	
# provide directories etc and log as volumes
VOLUME ["/opt/mobsos-monitor/etc/","/opt/mobsos-monitor/log"]