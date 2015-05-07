FROM learninglayers/base
MAINTAINER Petru Nicolaescu

# Add the war from Jenkins
ADD http://layers.dbis.rwth-aachen.de/jenkins/job/OpenIDConnect%20Server/lastSuccessfulBuild/artifact/openidconnectldapoverlay/ldap-server-overlay/target/o%23oauth2.war /opt/tomcat/webapps/o#oauth2.war
# Add init script to create mysql-db
ADD src/main/files/init/40_mysql.sh /opt/init/40_mysql.sh
