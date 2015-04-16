FROM learninglayers/base
MAINTAINER Yordan Manolov <yordan.manolov@dbis.rwth-aachen.de>

RUN apt-get -qqy --no-install-recommends install wget ca-certificates
# docker-gen needs to write to the Docker socket
ENV DSOCK /var/run/docker.sock
RUN mkdir -p $DSOCK
VOLUME ["$DSOCK"]

# docker-gen needs a location to write templates to
ENV TEMPLDIR /opt/templates
RUN mkdir -p $TEMPLDIR \
    && cd $TEMPLDIR \
    && wget https://raw.githubusercontent.com/jwilder/docker-gen/master/templates/nginx.tmpl
VOLUME ["$TEMPLDIR"]
