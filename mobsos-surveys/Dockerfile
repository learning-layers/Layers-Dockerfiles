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

# Download, unzip and start newest build from CI server
CMD wget http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Surveys/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
    unzip archive.zip && \
    mv archive mobsos-surveys && \
    cd mobsos-surveys && \
    dos2unix bin/start_network.sh && \
    chmod +x bin/start_network.sh && \
    bin/start_network.sh

EXPOSE 8080
