FROM learninglayers/tomcat
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

# Add the war from Jenkins
ADD http://layers.dbis.rwth-aachen.de/jenkins/job/Tethys-UserStorage/lastSuccessfulBuild/artifact/build/libs/workspace.war ${TOMCAT_HOME}/webapps/Tethys-UserStorage.war
