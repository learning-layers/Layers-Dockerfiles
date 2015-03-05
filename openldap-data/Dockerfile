FROM learninglayers/base

# add all files from conf subfolder to conf data volume 
ADD conf/ /usr/local/etc/openldap/

# Create a database folder
RUN mkdir /usr/local/etc/openldap/openldap-data

# provide directories conf and logs as volumes
VOLUME ["/usr/local/etc/openldap"]

CMD sed -i "s/LDAP_ROOT_PASSWORD/${LDAP_ROOT_PASSWORD}/g" /usr/local/etc/openldap/slapd.conf
