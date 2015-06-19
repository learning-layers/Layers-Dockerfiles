FROM learninglayers/base

MAINTAINER Dominik Renzel

RUN apt-get update

# Install build tools
RUN apt-get install -y \
                     wget \
                     unzip \
					 mysql-client \
                     dos2unix

WORKDIR /opt

RUN apt-get install -y software-properties-common
#RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN add-apt-repository -y ppa:webupd8team/java

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

# install Java 8
RUN apt-get update -yq
# RUN apt-get install -yq openjdk-8-jre

RUN apt-get install -yq oracle-java8-installer
RUN apt-get install oracle-java8-unlimited-jce-policy

# RUN update-java-alternatives -s java-8-oracle

# Download, unzip and start newest build from CI server
CMD wget -q http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Query%20Visualization/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
	#mkdir mobsos-query-visualization && \
	unzip archive.zip && \
	cd archive && \
	rm -rf etc doc && \
	echo "Moving stuff..." && \
	mv ./* ../mobsos-query-visualization && \
	cd .. && \
	rm -rf archive archive.zip && \
    cd mobsos-query-visualization && \
	echo "Getting here with user '$MS_USER' and pass '$MS_PASS'" &&\
	java -version && \
	which java && \
	echo $JAVA_HOME && \
	mysql -u$MS_USER -p$MS_PASS -hmysql < db.sql && \
	echo "Configured MobSOS Query Visualization database" && \
	dos2unix bin/start_ServiceAgentGenerator.sh && \
    chmod +x bin/start_ServiceAgentGenerator.sh && \
	#SERVICE_CLASS="i5.las2peer.services.queryVisualization.QueryVisualizationService" && \
	#mkdir -p etc/startup && \
	#echo "Generated startup directory" && \
	#bin/start_ServiceAgentGenerator.sh $SERVICE_CLASS aaaaa > etc/startup/agent-service-mobsos-query-visualization.xml && \
	#dos2unix etc/startup/agent-service-mobsos-query-visualization.xml && \
	# cat etc/startup/agent-service-mobsos-query-visualization.xml && \ 
	#echo "Created service agent" && \
	#echo "agent-service-mobsos-query-visualization.xml;aaaaa" > etc/startup/passphrases.txt && \
	ls etc/startup && \
	dos2unix bin/start_network.sh && \
    chmod +x bin/start_network.sh && \
	sed -i "s/someNewPass/qvPass/g" bin/start_network.sh && \
    bin/start_network.sh && \
	while true; do echo hello world; sleep 1; done

EXPOSE 8080
