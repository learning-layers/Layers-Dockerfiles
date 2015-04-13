FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

# Install build tools
ONBUILD RUN apt-get update -yq \

	&& apt-get install -yq software-properties-common \
	&& add-apt-repository -y ppa:webupd8team/java \
	&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections \

	&& apt-get update -yq \
	&& apt-get install -yq oracle-java8-installer wget \
	&& update-java-alternatives -s java-8-oracle \

        && wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-8/v8.0.21/bin/apache-tomcat-8.0.21.tar.gz -O - | tar -zxv -C /opt/ \
        && ln /opt/apache-tomcat-8.0.21/ /opt/tomcat 

ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"
ENV TOMCAT_HOME="/opt/tomcat"
ENV PATH=$JAVA_HOME/bin:$TOMCAT_HOME/bin:$PATH
		

