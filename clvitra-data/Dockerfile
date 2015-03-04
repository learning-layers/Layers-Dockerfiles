FROM learninglayers/base

MAINTAINER Aarij Siddiqui

ADD etc /etc/

CMD sed -i "s#DB_USERNAME#${DB_USERNAME}#g" /etc/clvitra/dbconnection.properties && \
	sed -i "s#DB_PASS#${DB_PASS}#g" /etc/clvitra/dbconnection.properties && \
	
	sed -i "s#TETHYS_USER#${TETHYS_USER}#g" /etc/clvitra/objectStore.properties && \
	sed -i "s#TETHYS_PASS#${TETHYS_PASS}#g" /etc/clvitra/objectStore.properties && \
	
	sed -i "s#CLIENT_ID#${CLIENT_ID}#g" /etc/clvitra/oidc.properties && \
	sed -i "s#CLIENT_SECRET#${CLIENT_SECRET}#g" /etc/clvitra/oidc.properties && \
	
VOLUME ["/etc/clvitra/"]