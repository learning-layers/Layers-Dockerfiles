FROM learninglayers/base
MAINTAINER Yordan Manolov <manolov@dbis.rwth-aachen.de>

# Add custom config
ADD conf/ /etc/freeradius

# Provide the config directory
ENV FR_RAD_CONF /etc/freeradius
RUN mkdir -p $FR_RAD_CONF
VOLUME ["$FR_RAD_CONF"]

CMD sed -i "s%${ldap_root_pass}%${LDAP_ROOT_PASSWORD}%g" /etc/freeradius/modules/ldap' \
    && sed -i "s%${IPofOpenLDAP}%${FR2OLDAP_PORT_389_TCP_ADDR}%g" /etc/freeradius/modules/ldap'
