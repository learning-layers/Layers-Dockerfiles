FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

# Environment variables
ENV INSTALL_DIR="/opt"
ENV INIT_SH="${INSTALL_DIR}/init.sh" \
	INIT_DIR="${INSTALL_DIR}/init" \
	JAVA_HOME="/usr/lib/jvm/java-8-oracle" \
	TOMCAT_HOME="${INSTALL_DIR}/tomcat"
ENV PATH=$JAVA_HOME/bin:$PATH

# Add startscripts
ADD src/main/files/init.sh	${INIT_SH}
ADD src/main/files/init		${INIT_DIR}

# Install Java 8 & Tomcat 8
ONBUILD RUN apt-get update -yq \

	# make initscript runable
	&& chmod +x ${INIT_SH} \

	# add Java 8 repository
	&& apt-get install -yq software-properties-common \
	&& add-apt-repository -y ppa:webupd8team/java \
	&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections \

	# install Java 8
	&& apt-get update -yq \
	&& apt-get install -yq oracle-java8-installer wget \
	&& update-java-alternatives -s java-8-oracle \
	
	# install Tomcat 8 
        && wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz -O - | tar -zxv -C ${INSTALL_DIR}/ \
        && ln -s ${INSTALL_DIR}/apache-tomcat-8.0.21/ ${TOMCAT_HOME}


# Expose Tomcat at port 8080 & start our initscripts		
EXPOSE 8080
CMD ${INIT_SH}
