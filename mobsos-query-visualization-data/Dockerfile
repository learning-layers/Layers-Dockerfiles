FROM learninglayers/base

MAINTAINER Dominik Renzel

# add content to data volumes
ADD etc /opt/mobsos-query-visualization/etc

# do necessary replacements by environment variable values (
CMD sed -i "s#LAYERS_API_URI#${LAYERS_API_URI}#g" /opt/mobsos-query-visualization/etc/i5.las2peer.webConnector.WebConnector.properties && \
	sed -i "s#LAYERS_API_URI#${LAYERS_API_URI}#g" /opt/mobsos-query-visualization/etc/i5.las2peer.services.queryVisualization.QueryVisualizationService.properties && \
	sed -i "s#MS_DB#${MS_DB}#g" /opt/mobsos-query-visualization/etc/i5.las2peer.services.queryVisualization.QueryVisualizationService.properties && \
	sed -i "s#MS_USER#${MS_USER}#g" /opt/mobsos-query-visualization/etc/i5.las2peer.services.queryVisualization.QueryVisualizationService.properties && \
	sed -i "s#MS_PASS#${MS_PASS}#g" /opt/mobsos-query-visualization/etc/i5.las2peer.services.queryVisualization.QueryVisualizationService.properties && \
	sed -i "s#MS_OIDC_CLIENT_ID#${MS_OIDC_CLIENT_ID}#g" /opt/mobsos-query-visualization/etc/i5.las2peer.services.queryVisualization.QueryVisualizationService.properties
	
# provide directory as volume
VOLUME ["/opt/mobsos-query-visualization/etc/"]