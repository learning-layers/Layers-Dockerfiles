FROM learninglayers/base

RUN apt-get install -y wget \
					   tar \
					   libreadline-dev \
					   libncurses5-dev \
					   libpcre3-dev \
					   libssl-dev \
					   perl \
					   make

WORKDIR /opt
RUN wget http://openresty.org/download/ngx_openresty-1.7.7.2.tar.gz && \
	tar xvzf ngx_openresty-1.7.7.2.tar.gz && \
	cd ngx_openresty-1.7.7.2 && \
	./configure --with-pcre-jit --with-ipv6 && \
	make && \
	make install

WORKDIR /usr/local/openresty
EXPOSE 80

CMD /usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/conf/nginx.conf
