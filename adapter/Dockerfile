FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# Install build dependencies
RUN apt-get install -qqy \
                         wget \
			 tar \
			 libreadline-dev \
			 libncurses5-dev \
			 libpcre3-dev \
			 libssl-dev \
			 perl \
			 make \
                         ca-certificates

# Set build dir
WORKDIR /opt
ENV OPENRESTY_VERSION 1.7.10.1

RUN wget http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz && \
	tar xvzf ngx_openresty-${OPENRESTY_VERSION}.tar.gz && \
	cd ngx_openresty-* && \
	./configure --with-pcre-jit --with-ipv6 && \
	make && \
	make install

WORKDIR /usr/local/openresty

## Make sure the docker log collector has access to the openresty logs
#RUN ln -s /dev/stdout /var/log/nginx/access.log
#RUN ln -s /dev/stderr /var/log/nginx/error.log

# Provide volume for debugging purposes
VOLUME ["/var/cache/nginx"]

# Install docker-gen
ENV DGEN_VER 0.3.9
ENV DLURLDG https://github.com/jwilder/docker-gen/releases/download/$DGEN_VER/docker-gen-linux-amd64-$DGEN_VER.tar.gz
ENV DLURLFG https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego

RUN wget ${DLURLDG} \
    && tar -C /usr/local/bin -xvzf docker-gen* \
    && chmod 755 /usr/local/bin/docker-gen*
    && rm docker-gen* \
    && rm -rf /var/lib/apt/lists/*

# Install Forego
RUN wget -P /usr/local/bin ${DLURLFG} \
    && chmod 755 /usr/local/bin/forego

## Generate config file
#RUN docker-gen -notify-sighup nginx -watch --only-published /usr/local/docker-gen/templates/nginx.tmpl /usr/local/openresty/docker-gen-generated.conf 

EXPOSE 80 443

CMD forego start -r && /usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/conf/nginx.conf -g daemon off 
