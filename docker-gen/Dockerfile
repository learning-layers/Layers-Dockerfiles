FROM learninglayers/adapter #learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

ENV DGEN_VER 0.3.7
ENV DLURLDG https://github.com/jwilder/docker-gen/releases/download/$DGEN_VER/docker-gen-linux-amd64-$DGEN_VER.tar.gz
ENV DLURLFG https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego

# Install docker-gen 
# WORKDIR /opt
RUN apt-get install -qqy --no-install-recommends \
                    wget \
                    ca-certificates \ 
    && wget ${DLURLDG} \
    && tar -C /usr/local/bin -xvzf docker-gen* \
    && rm docker-gen* \
    && rm -rf /var/lib/apt/lists/*

## Start docker-gen
#ENTRYPOINT ["/usr/local/bin/docker-gen"]
 
# Install Forego
RUN wget -P /usr/local/bin ${DLURLFG} \
    && chmod 777 /usr/local/bin/forego

# Run Forego
ENTRYPOINT ["forego"]
CMD ["start", "-r"]
