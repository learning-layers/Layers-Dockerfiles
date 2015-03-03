FROM learninglayers/base

MAINTAINER Petru Nicolaescu

# Add MITREid config files
ADD etc /etc/sql
ADD data-context.xml /etc/mitreid-connect/data-context.xml
ADD server-config.xml /etc/mitreid-connect/server-config.xml
ADD user-context.xml /etc/mitreid-connect/user-context.xml

CMD sed -i "s/OIDC_MYSQL_USER/${OIDC_MYSQL_USER}/g" /etc/mitreid-connect/data-context.xml && \
	sed -i "s/OIDC_MYSQL_PASSWORD/${OIDC_MYSQL_PASSWORD}/g" /etc/mitreid-connect/data-context.xml

VOLUME ["/etc/mitreid-connect","etc/sql"]
