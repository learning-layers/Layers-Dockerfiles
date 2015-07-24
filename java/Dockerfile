FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# Environment variables
ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle" 
ENV PATH=$JAVA_HOME/bin:$PATH

# Environment variables - Tomcat 
ENV TOMCAT_HOME="${INSTALL_DIR}/tomcat"
ENV TOMCAT_MAJOR_VER="7"

# Install Java 7 
ONBUILD RUN apt-get update -yq \

	# add Java 7 repository
	&& apt-get install -yq software-properties-common \
	&& add-apt-repository -y ppa:webupd8team/java \
	&& echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections \

	# install Java 7
	&& apt-get install -yq oracle-java7-installer \
	&& update-java-alternatives -s java-7-oracle \
  && update-java-alternatives -s java-7-oracle 
