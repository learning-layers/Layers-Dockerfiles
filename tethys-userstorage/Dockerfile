FROM learninglayers/tomcat
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

ENV	TUS="${TOMCAT_HOME}/webapps/Tethys-UserStorage" \
	TUS_WAR="${TOMCAT_HOME}/webapps/Tethys-UserStorage.war"

# Add to the other startscripts
ADD src/main/files/init		${INIT_DIR}

# Add the war from Jenkins
ADD http://layers.dbis.rwth-aachen.de/jenkins/job/Tethys-UserStorage/lastSuccessfulBuild/artifact/build/libs/workspace.war ${TUS_WAR}
