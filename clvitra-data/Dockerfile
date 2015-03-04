FROM learninglayers/base

MAINTAINER Aarij Siddiqui

ADD clvitra/ /var/

CMD sed -i "s#DB_USERNAME#${DB_USERNAME}#g" /var/clvitra/dbconnection.properties && \
	sed -i "s#DB_PASS#${DB_PASS}#g" /var/clvitra/dbconnection.properties && \
	
	sed -i "s#TETHYS_USER#${TETHYS_USER}#g" /var/clvitra/objectStore.properties && \
	sed -i "s#TETHYS_PASS#${TETHYS_PASS}#g" /var/clvitra/objectStore.properties && \
	
	sed -i "s#CLIENT_ID#${CLIENT_ID}#g" /var/clvitra/oidc.properties && \
	sed -i "s#CLIENT_SECRET#${CLIENT_SECRET}#g" /var/clvitra/oidc.properties && \
	
VOLUME ["/var/clvitra/"]