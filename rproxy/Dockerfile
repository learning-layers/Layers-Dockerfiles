FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# This is the Layers Dockerfile for the reverse proxy
# First, install build dependencies
# Refer to http://openresty.org/#Installation

RUN apt-get install -qqy --no-install-recommends libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make wget curl

# From ficusio / openresty:
ENV OPENRESTY_VERSION 1.7.10.1
ENV OPENRESTY_PREFIX /opt/openresty
ENV NGINX_PREFIX /opt/openresty/nginx
ENV VAR_PREFIX /var/nginx

RUN cd /root \
 && echo "==> Downloading OpenResty..." \
 && curl -sSL http://openresty.org/download/ngx_openresty-${OPENRESTY_VERSION}.tar.gz | tar -xvz \
 && echo "==> Configuring OpenResty..." \
 && cd ngx_openresty-* \
 && readonly NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
 && echo "using upto $NPROC threads" \
 && ./configure \
    --prefix=$OPENRESTY_PREFIX \
    --http-client-body-temp-path=$VAR_PREFIX/client_body_temp \
    --http-proxy-temp-path=$VAR_PREFIX/proxy_temp \
    --http-log-path=$VAR_PREFIX/access.log \
    --error-log-path=$VAR_PREFIX/error.log \
    --pid-path=$VAR_PREFIX/nginx.pid \
    --lock-path=$VAR_PREFIX/nginx.lock \
    --with-luajit \
    --with-pcre-jit \
    --with-ipv6 \
    --with-http_ssl_module \
  #  --without-http_ssi_module \
  #  --without-http_userid_module \
  #  --without-http_fastcgi_module \
  #  --without-http_uwsgi_module \
  #  --without-http_scgi_module \
  #  --without-http_memcached_module \
    -j${NPROC} \
 && echo "==> Building OpenResty..." \
 && make -j${NPROC} \
 && echo "==> Installing OpenResty..." \
 && make install \
 && echo "==> Finishing..." \
 && ln -sf $NGINX_PREFIX/sbin/nginx /usr/local/bin/nginx \
 && ln -sf $NGINX_PREFIX/sbin/nginx /usr/local/bin/openresty \
 && ln -sf $OPENRESTY_PREFIX/bin/resty /usr/local/bin/resty \
 && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* $OPENRESTY_PREFIX/luajit/bin/lua \
 && ln -sf $OPENRESTY_PREFIX/luajit/bin/luajit-* /usr/local/bin/lua \
 && rm -rf /root/ngx_openresty*

WORKDIR $NGINX_PREFIX/

#ONBUILD RUN rm -rf conf/* html/*
#ONBUILD COPY nginx $NGINX_PREFIX/

## The Docker log collector should be able to read nginx logs
#RUN ln -sf /dev/stdout /var/log/nginx/access.log
#RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Provide volume for debugging purposes
VOLUME ["/var/cache/nginx"]

# Quoted from the nginx developers' image for Docker:
#
# Be sure to include daemon off; in your custom configuration to ensure that Nginx stays in the foreground 
# so that Docker can track the process properly
# (otherwise your container will stop immediately after starting)!
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off; error_log /dev/stderr info;"]
