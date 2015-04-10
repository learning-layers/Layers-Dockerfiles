FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# This is the Layers Dockerfile for the reverse proxy
# First, install ngnix
RUN apt-get install -yq --no-instsall-recommends ca-certificates ngnix

# The Docker log collector should be able to read nginx logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Provide volume for debugging purposes
VOLUME ["/var/cache/nginx"]

# Quoted from the nginx developer's image for Docker:
#
# Be sure to include daemon off; in your custom configuration to ensure that Nginx stays in the foreground 
# so that Docker can track the process properly
# (otherwise your container will stop immediately after starting)!
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
