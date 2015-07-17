FROM learninglayers/tomcat
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

ENV	APP_NAME="TethysLDAPConnector"
ENV     APP_DIR="${TOMCAT_HOME}/webapps/${APP_NAME}" \
        APP_WAR="${TOMCAT_HOME}/webapps/${APP_NAME}.war"

# Add to the other startscripts
ADD src/main/files/init         ${INIT_DIR}

# Add the war from Jenkins
ADD http://layers.dbis.rwth-aachen.de/jenkins/job/${APP_NAME}/lastSuccessfulBuild/artifact/build/libs/workspace.war ${APP_WAR}
