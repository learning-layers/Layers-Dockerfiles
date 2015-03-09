FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

RUN apt-get update -yq \
	&& apt-get install -yq software-properties-common \
	&& add-apt-repository -y ppa:webupd8team/java \
	&& sudo add-apt-repository ppa:cwchien/gradle \
	&& echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections \
	&& apt-get update -yq \
	&& apt-get install -yq oracle-java8-installer tomcat7 gradle \
	&& update-java-alternatives -s java-8-oracle
	
ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle/"
ENV PATH=$JAVA_HOME/bin:$PATH
#ENV JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8

ADD ./ /opt/tethysuserstorage/
RUN cd /opt/tethysuserstorage \
	&& chmod -R +x ./ \
	&& gradle clean build \
	&& mv ./build/libs/tethysuserstorage.war /var/lib/tomcat7/webapps/ROOT.war \ 
	&& rm -R /var/lib/tomcat7/webapps/ROOT
 
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle/" >> /etc/default/tomcat7

EXPOSE 8080

CMD service tomcat7 start \
	&&  tail -f /var/log/tomcat7/catalina.out