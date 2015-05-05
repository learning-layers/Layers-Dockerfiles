FROM learninglayers/tomcat
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>
 
ADD account/ $TOMCAT_HOME/webapps 
RUN cp /opt/conf/PwmConfiguration.xml $TOMCAT_HOME/webapps/WEB-INF

ENTRYPOINT ["$TOMCAT_HOME/webapps/index.jsp"]
