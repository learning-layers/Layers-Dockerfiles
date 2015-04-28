FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

RUN apt-get -qqy --no-install-recommends install wget ca-certificates

# docker-gen needs a location to write templates to
ENV TEMPLDIR /opt/templates
RUN mkdir -p $TEMPLDIR \
    && cd $TEMPLDIR \
    && wget https://raw.githubusercontent.com/jwilder/docker-gen/master/templates/nginx.tmpl
VOLUME ["$TEMPLDIR"]
