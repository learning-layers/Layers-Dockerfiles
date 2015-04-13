FROM learninglayers/tomcat
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

RUN wget http://layers.dbis.rwth-aachen.de/jenkins/job/Tethys-UserStorage/lastSuccessfulBuild/artifact/build/libs/Tethys-UserStorage.war && 

ADD ./ /opt/tethysuserstorage/
RUN cd /opt/tethysuserstorage \
	&& chmod -R +x ./ \
	&& gradle clean build \
	&& mv ./build/libs/tethysuserstorage.war /var/lib/tomcat7/webapps/ROOT.war \ 
	&& rm -R /var/lib/tomcat7/webapps/ROOT
 
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle/" >> /etc/default/tomcat7

EXPOSE 8080

CMD service tomcat7 start \
	&&  tail -f /var/log/tomcat7/catalina.out