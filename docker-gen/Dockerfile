FROM learninglayers/base
MAINTAINER Yordan Manolov <yordan.manolov@dbis.rwth-aachen.de>

ENV DGEN_VER 0.3.7
ENV DLURL https://github.com/jwilder/docker-gen/releases/download/$DGEN_VER/docker-gen-linux-amd64-$DGEN_VER.tar.gz

# Install docker-gen 
WORKDIR /opt
RUN apt-get install -qqy --no-install-recommends \
                    wget \
                    ca-certificates \ 
    && wget ${DLURL} \
    && tar -C /usr/local/bin -xvzf docker-gen.tar.gz \
    && rm docker-gen.tar.gz \
    && rm -rf /var/lib/apt/lists/*

# Start docker-gen
ENTRYPOINT ["/usr/local/bin/docker-gen"]

