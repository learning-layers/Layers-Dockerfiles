FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

# Add startscripts
ADD src/main/files/init.sh	/opt/init.sh
ADD src/main/files/init		/opt/init

# Use most current Tomcat ver 7
ENV TCVER 7.0.62

# Install Java 7 & Tomcat 7
ONBUILD RUN apt-get update -yq \

	# make initscripts runable
	&& chmod +x /opt/init.sh \
	&& chmod -R +x /opt/init \

	# add Java repository
	&& apt-get install -yq software-properties-common \
	&& add-apt-repository -y ppa:webupd8team/java \
	&& echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections \

	# install Java 7
	&& apt-get update -yq \
	&& apt-get install -yq oracle-java7-installer wget \
	&& update-java-alternatives -s java-7-oracle \
	
	# install Tomcat 7 
        && wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-7/v${TCVER}/bin/apache-tomcat-${TCVER}.tar.gz -O - | tar -zxv -C /opt/ \
        && ln -s /opt/apache-tomcat-${TCVER}/ /opt/tomcat 

# Add Environment variables
ENV JAVA_HOME="/usr/lib/jvm/java-7-oracle"
ENV TOMCAT_HOME="/opt/tomcat"
ENV PATH=$JAVA_HOME/bin:$TOMCAT_HOME/bin:$PATH

# Expose Tomcat at port 8080 & start our initscripts		
EXPOSE 8080
CMD /opt/init.sh

#VOLUME ["/opt/tomcat/conf", "/opt/tomcat/webapps"]
