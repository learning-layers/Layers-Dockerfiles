FROM learninglayers/base

MAINTAINER Dominik Renzel

# install mysql client
RUN apt-get -y install mysql-client

# Install build tools
RUN apt-get install -y \
                     wget \
                     unzip \
					 mysql-client \
                     openjdk-7-jre \
                     dos2unix

CMD mkdir /opt
WORKDIR /opt

# Download and unzip newest build from CI server
# Start the mysql daemon
# dos2unix fixes the "textfile open" error
CMD wget http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Monitor/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
    unzip archive.zip && \
	mv archive mobsos-monitor && \
    cd mobsos-monitor && \
	mysql -uroot -ppass -hmysql mobsos_monitor < etc/sql/schema.sql && \
	dos2unix bin/start.sh && \
    chmod +x bin/start.sh && \
    bin/start.sh
