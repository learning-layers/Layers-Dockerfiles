FROM learninglayers/base

MAINTAINER Dominik Renzel

# add content to data volumes
ADD etc /opt/mobsos-surveys/etc
ADD doc /opt/mobsos-surveys/doc

# do necessary replacements by environment variable values (
CMD sed -i "s#MS_DB#${MS_DB}#g" /opt/mobsos-surveys/etc/sql/schema.sql && \
	sed -i "s#MS_USER#${MS_USER}#g" /opt/mobsos-surveys/etc/sql/schema.sql && \
	sed -i "s#MS_PASS#${MS_PASS}#g" /opt/mobsos-surveys/etc/sql/schema.sql && \
	sed -i "s#LAYERS_API_URI#${LAYERS_API_URI}#g" /opt/mobsos-surveys/etc/i5.las2peer.webConnector.WebConnector.properties && \
	sed -i "s#LAYERS_API_URI#${LAYERS_API_URI}#g" /opt/mobsos-surveys/etc/i5.las2peer.services.mobsos.SurveyService.properties && \
	sed -i "s#MS_DB#${MS_DB}#g" /opt/mobsos-surveys/etc/i5.las2peer.services.mobsos.SurveyService.properties && \
	sed -i "s#MS_USER#${MS_USER}#g" /opt/mobsos-surveys/etc/i5.las2peer.services.mobsos.SurveyService.properties && \
	sed -i "s#MS_PASS#${MS_PASS}#g" /opt/mobsos-surveys/etc/i5.las2peer.services.mobsos.SurveyService.properties && \
	sed -i "s#MS_OIDC_CLIENT_ID#${MS_OIDC_CLIENT_ID}#g" /opt/mobsos-surveys/etc/i5.las2peer.services.mobsos.SurveyService.properties
	
# provide directories etc and log as volumes
VOLUME ["/opt/mobsos-surveys/etc/","/opt/mobsos-surveys/doc"]