FROM learninglayers/base

MAINTAINER Aarij Siddiqui <siddiqui ÄT dbis.rwth-aachen.de>

# Install build tools
RUN apt-get install -y \
                     openjdk-7-jdk \
                     wget

WORKDIR /home/docker/
					 
# Set jdk7 as the default JDK
RUN ln -fs /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /etc/alternatives/java && \
	wget http://layers.dbis.rwth-aachen.de/jenkins/job/Cloud-Video-Transcoder/lastSuccessfulBuild/artifact/ClViTra_2.0/target/clvitra.war -O /usr/clvitra.war && \

	# Install Tomcat Server & deploy the service
	mkdir /home/docker/temp && \
	mkdir /home/docker/tomcat && \
	mkdir /home/docker/tempdircopy && \
	wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz -O  /home/docker/tempdircopy/apache-tomcat-8.0.21.tar.gz && \
	tar -zxvf /home/docker/tempdircopy/apache-tomcat-8.0.21.tar.gz -C /home/docker/tempdircopy && \
	
	# Copy the tomcat to the right location
    cp -r /home/docker/tempdircopy/apache-tomcat-8.0.21/* /home/docker/tomcat && \
	cp -r /usr/clvitra.war /home/docker/tomcat/webapps
		
# Start Tomcat Server
CMD	/home/docker/tomcat/bin/catalina.sh run && \
	#rabbitmqctl start_app && \
	#rabbitmq-server -detached && \

EXPOSE 8080

