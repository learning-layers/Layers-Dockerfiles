FROM learninglayers/tomcat
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

RUN	wget http://layers.dbis.rwth-aachen.de/jenkins/job/Tethys-UserStorage/lastSuccessfulBuild/artifact/build/libs/workspace.war -O /opt/tomcat/webapps/Tethys-UserStorage.war

CMD /opt/tomcat/bin/startup.sh && tail -f /opt/tomcat/logs/catalina.out
