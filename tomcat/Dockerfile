FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

# Add startscripts
ADD src/main/files/init.sh	/opt/init.sh
ADD src/main/files/init		/opt/init

# Install Java 8 & Tomcat 8
ONBUILD RUN apt-get update -yq \

	# make initscripts runable
	&& chmod +x /opt/init.sh \
	&& chmod -R +x /opt/init \

	# add Java 8 repository
	&& apt-get install -yq software-properties-common \
	&& add-apt-repository -y ppa:webupd8team/java \
	&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections \

	# install Java 8
	&& apt-get update -yq \
	&& apt-get install -yq oracle-java8-installer wget \
	&& update-java-alternatives -s java-8-oracle \
	
	# install Tomcat 8 
        && wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz -O - | tar -zxv -C /opt/ \
        && ln -s /opt/apache-tomcat-8.0.21/ /opt/tomcat 

# Add Environment variables
ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"
ENV TOMCAT_HOME="/opt/tomcat"
ENV PATH=$JAVA_HOME/bin:$TOMCAT_HOME/bin:$PATH

# Expose Tomcat at port 8080 & start our initscripts		
EXPOSE 8080
CMD /opt/init.sh

#VOLUME ["/opt/tomcat/conf", "/opt/tomcat/webapps"]
