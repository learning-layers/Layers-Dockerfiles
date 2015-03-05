FROM learninglayers/base

MAINTAINER Dominik Renzel

RUN apt-get install -y \
                     wget \
                     unzip \
                     python

WORKDIR /var/www

CMD wget http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Surveys/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
    unzip archive.zip && \
	mv archive/webapp . && \
	rm -rf archive && \
	rm -f archive.zip && \
    cd webapp && \
    python -m SimpleHTTPServer 8080

EXPOSE 8080	