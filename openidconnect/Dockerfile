FROM learninglayers/tomcat:7
MAINTAINER Petru Nicolaescu

# Add the war from Jenkins
ADD http://layers.dbis.rwth-aachen.de/jenkins/job/OpenIDConnect%20Server/lastSuccessfulBuild/artifact/openidconnectldapoverlay/ldap-server-overlay/target/o%23oauth2.war ${TOMCAT_HOME}/webapps/o#oauth2.war

# Add init script to create mysql-db
ADD src/main/files/init /opt/init
