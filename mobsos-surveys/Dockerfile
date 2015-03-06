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
	echo "Moving stuff..." && \
	mv ./* ../mobsos-surveys && \
	cd .. && \
	rm -rf archive archive.zip && \
    cd mobsos-surveys && \
	mysql -uroot -p$MYSQL_ROOT_PASSWORD -hmysql < etc/sql/schema.sql && \
	dos2unix bin/start_ServiceAgentGenerator.sh && \
    chmod +x bin/start_ServiceAgentGenerator.sh && \
	MS_SERVICE_CLASS="i5.las2peer.services.mobsos.SurveyService" && \
	mkdir etc/startup && \
	bin/start_ServiceAgentGenerator.sh $MS_SERVICE_CLASS $MS_PASS > etc/startup/agent-service-mobsos-surveys.xml && \
	echo "agent-service-mobsos-surveys.xml;$MS_PASS" > etc/startup/passphrases.txt && \
	dos2unix bin/start_network.sh && \
    chmod +x bin/start_network.sh && \
	sed -i "s/mobsosrules/$MS_PASS/g" bin/start_network.sh && \
    bin/start_network.sh && \
	while true; do echo hello world; sleep 1; done

EXPOSE 8080
