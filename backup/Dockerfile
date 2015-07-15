FROM learninglayers/base

MAINTAINER Andreas Guth

RUN apt-get update -q && apt-get install -y libjs-sphinxdoc python3-msgpack
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/a/attic/attic_0.13-1_amd64.deb
RUN dpkg -i attic_0.13-1_amd64.deb
RUN rm attic_0.13-1_amd64.deb
