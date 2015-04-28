FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# Add custom config
ADD conf/ /etc/freeradius

# Provide the config directory
ENV FR_RAD_CONF /etc/freeradius
RUN mkdir -p $FR_RAD_CONF
VOLUME ["$FR_RAD_CONF"]
