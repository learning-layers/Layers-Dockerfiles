# Current Ubuntu LTS image
FROM ubuntu:14.04

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Make sure that bash (not dash) is the default shell
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Perform updates
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
ONBUILD RUN apt-get update \
    && apt-get upgrade \ 
    -qqy \ 
    --no-install-recommends \ 
    --only-upgrade
