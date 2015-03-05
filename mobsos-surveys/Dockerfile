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

WORKDIR /opt

# Download, unzip and start newest build from CI server
CMD wget http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Surveys/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
    unzip archive.zip && \
	cd archive && \
	rm -rf etc doc && \
	mv ./* ../mobsos-surveys && \
	cd .. && \
	rm -rf archive archive.zip && \
    cd mobsos-surveys && \
	dos2unix bin/start_ServiceAgentGenerator.sh && \
    chmod +x bin/start_ServiceAgentGenerator.sh && \
	dos2unix bin/start_network.sh && \
    chmod +x bin/start_network.sh && \
	
    #bin/start_network.sh
	while true; do echo hello world; sleep 1; done

EXPOSE 8080
