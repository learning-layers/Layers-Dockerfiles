FROM learninglayers/base

MAINTAINER Dominik Renzel

RUN apt-get update
RUN apt-get install -y \
                     wget \
                     unzip \
                     python

WORKDIR /var/www

CMD wget -q http://layers.dbis.rwth-aachen.de/jenkins/job/MobSOS%20Query%20Visualization/lastSuccessfulBuild/artifact/*zip*/archive.zip && \
    unzip archive.zip && \
	mv archive/frontend . && \
	rm -rf archive && \
	rm -f archive.zip && \
    cd frontend && \
	mv demo.html index.html && \
    python -m SimpleHTTPServer 8080

EXPOSE 8080	