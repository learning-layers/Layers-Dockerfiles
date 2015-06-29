FROM learninglayers/base

MAINTAINER Aarij Siddiqui

# install mysql client
RUN apt-get -y install mysql-client

# Install build tools
RUN apt-get install -y \
                     wget \
                     unzip \
					 mysql-client \
                     openjdk-8-jre \
                     dos2unix

WORKDIR /opt

# Download, unzip and start newest build from CI server
CMD wget http://layers.dbis.rwth-aachen.de/jenkins/job/LAS2peer-Vaptor-Adapter-Service/lastSuccessfulBuild/artifact/*zip*/archive.zip && \

	unzip archive.zip && \
	cd archive && \
	echo "Moving stuff..." && \
	mv ./* ../vaptor-adapter && \
	cd .. && \
	rm -rf archive archive.zip && \
    cd vaptor-adapter && \
	MS_SERVICE_CLASS="i5.las2peer.services.videoAdapter.AdapterClass" && \
	dos2unix bin/start_network.sh && \
    chmod +x bin/start_network.sh && \
    bin/start_network.sh && \
	while true; do echo hello world; sleep 1; done

EXPOSE 8080