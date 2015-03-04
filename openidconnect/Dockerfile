FROM learninglayers/base

MAINTAINER Petru Nicolaescu

# install mysql client
RUN apt-get -y install mysql-client

# Install build tools
RUN apt-get install -y \
                     wget \
                     unzip \
					 openjdk-7-jre \
                     dos2unix

RUN mkdir /opt
WORKDIR /opt

CMD wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.tar.gz -O  /tempdircopy/apache-tomcat-7.0.59.tar.gz  && \
	tar -zxvf /tempdircopy/apache-tomcat-8.0.18.tar.gz && \
	wget http://layers.dbis.rwth-aachen.de/jenkins/job/OpenIDConnect%20Server/lastSuccessfulBuild/artifact/openidconnectldapoverlay/ldap-server-overlay/target/o#oauth2.war /opt/apache-tomcat-8.0.18/webapps && \
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -hmysql < etc/sql/schema.sql && \
  	/opt/apache-tomcat-8.0.18/bin/catalina.sh run

EXPOSE 8080
