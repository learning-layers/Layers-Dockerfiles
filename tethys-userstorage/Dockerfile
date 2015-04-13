FROM learninglayers/tomcat
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>


RUN cd /opt/tomcat/webapps \
	&& wget http://layers.dbis.rwth-aachen.de/jenkins/job/Tethys-UserStorage/lastSuccessfulBuild/artifact/build/libs/Tethys-UserStorage.war


EXPOSE 8080

CMD /opt/tomcat/bin/startup.sh