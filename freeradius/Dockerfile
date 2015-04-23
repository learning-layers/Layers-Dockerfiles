FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# Install FreeRADIUS
RUN apt-get update \
 && apt-get -qqy --no-install-recommends install \
                                 freeradius \
                                 freeradius-common \
                                 freeradius-utils \
                                 libfreeradius2 \
                                 freeradius-ldap \
                                 freeradius-mysql \
                                 libdbi-perl \
 && rm -r /var/lib/apt/lists/*

## In Debian-based GNU/Linux OSs, the radiusd daemon is called freeradius.
## The same applies to the config dir, which is /etc/freeradius instead of /etc/raddb
#RUN ln -s /usr/sbin/freeradius /usr/bin/radiusd

## According to the project's Technical Guide, firewall rules need to be added
#RUN ufw allow 1812/udp
#RUN ufw allow 1813/udp

EXPOSE 1812/udp
EXPOSE 1813/udp

CMD ["/usr/sbin/freeradius", "-f", "-xx"]
