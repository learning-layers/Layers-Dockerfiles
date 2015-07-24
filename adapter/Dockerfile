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

# Make sure the docker log collector has access to the openresty logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Provide volume for debugging purposes
VOLUME ["/var/cache/nginx"]


EXPOSE 80 443

CMD /usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/conf/nginx.conf #-g daemon off
