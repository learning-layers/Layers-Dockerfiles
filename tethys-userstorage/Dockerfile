FROM learninglayers/tomcat
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

RUN	wget http://layers.dbis.rwth-aachen.de/jenkins/job/Tethys-UserStorage/lastSuccessfulBuild/artifact/build/libs/workspace.war -O /opt/tomcat/webapps/Tethys-UserStorage.war

ADD src/main/files/startmain.sh /opt/startmain.sh
RUN chmod 755 /opt/startmain.sh

CMD /opt/startmain.sh
