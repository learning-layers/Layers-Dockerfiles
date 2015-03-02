FROM learninglayers/base

# add files to data volume 
ADD etc /opt/mobsos-monitor/etc

# in MobSOS Monitor config replace API url (environment variable $LAYERS_API_URL), database user and generated password (environment variables $MM_USER and $MM_PASS)
CMD sed -i "s/LAYERS_API_URL/${LAYERS_API_URL}/g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s/PASSWORD/${MM_PASS}/g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s/USER/${MM_USER}/g" /opt/mobsos-monitor/etc/conf.properties && \
	sed -i "s/DATABASE/${MM_DB}/g" /opt/mobsos-monitor/etc/conf.properties && \
	cat /opt/mobsos-monitor/etc/conf.properties

# provide directory etc as volume
VOLUME ["/opt/mobsos-monitor/etc/"]