FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

# Environment variables
ENV INSTALL_DIR="/opt"
ENV INIT_SH="${INSTALL_DIR}/init.sh" \
	INIT_DIR="${INSTALL_DIR}/init" \
	JAVA_HOME="/usr/lib/jvm/java-8-oracle" \
	TOMCAT_HOME="${INSTALL_DIR}/tomcat"
ENV PATH=$JAVA_HOME/bin:$PATH

# Environment variables - Tomcat 
ENV TOMCAT_HOME="${INSTALL_DIR}/tomcat"
ENV TOMCAT_MAJOR_VER="8"

# Add startscripts
ADD src/main/files/init.sh	/opt/init.sh
ADD src/main/files/init		/opt/init


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
        && TARB_PAR_LOC="ftp://ftp.halifax.rwth-aachen.de/apache/tomcat/tomcat-${TOMCAT_MAJOR_VER}" \
	&& TOMCAT_MINOR_VER_VPREFIX=$(curl -l ${TARB_PAR_LOC}/ | tail -n 1) \
	&& TOMCAT_MINOR_VER=$(echo ${TOMCAT_MINOR_VER_VPREFIX} | cut -c 2-) \
	&& TARB_SUBLOC=${TARB_PAR_LOC}/${TOMCAT_MINOR_VER_VPREFIX}/ \
	&& TARB_LOC=${TARB_SUBLOC}bin/apache-tomcat-${TOMCAT_MINOR_VER}.tar.gz  \

        && wget ${TARB_LOC} -O - | tar -zxv -C ${INSTALL_DIR}/ \
	&& ln -s ${INSTALL_DIR}/apache-tomcat-${TOMCAT_MINOR_VER}/ ${TOMCAT_HOME}

# Expose Tomcat at port 8080 & start our initscripts		
EXPOSE 8080
CMD /opt/init.sh

#VOLUME ["/opt/tomcat/conf", "/opt/tomcat/webapps"]
