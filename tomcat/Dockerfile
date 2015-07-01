FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

ENV INSTALL_DIR="/opt"
ENV INIT_SH="${INSTALL_DIR}/init.sh"
ENV INIT_DIR="${INSTALL_DIR}/init"
ENV JAVA_HOME="/usr/lib/jvm/java-7-oracle"
ENV TOMCAT_HOME="/opt/tomcat"
ENV PATH=$JAVA_HOME/bin:$TOMCAT_HOME/bin:$PATH

# Add startscripts
ADD src/main/files/init.sh	/opt/init.sh
ADD src/main/files/init		/opt/init

# Use most current Tomcat ver 7
ENV TCVER 7.0.62

# Install Java 7 & Tomcat 7
RUN apt-get update -yq && \
    apt-get install -yq software-properties-common

# add Java repository
RUN add-apt-repository -y ppa:webupd8team/java && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

# make initscripts runable
RUN chmod +x /opt/init.sh && \
    chmod -R +x /opt/init

# install Java 7
RUN apt-get update -yq && \ 
    apt-get install -yq oracle-java7-installer wget
RUN update-java-alternatives -s java-7-oracle
	
# install Tomcat 7 
RUN wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-7/v${TCVER}/bin/apache-tomcat-${TCVER}.tar.gz -O - | tar -zxv -C /opt/ && \
    ln -s /opt/apache-tomcat-${TCVER}/ /opt/tomcat 

# Expose Tomcat at port 8080 & start our initscripts		
EXPOSE 8080
CMD /opt/init.sh

#VOLUME ["/opt/tomcat/conf", "/opt/tomcat/webapps"]
