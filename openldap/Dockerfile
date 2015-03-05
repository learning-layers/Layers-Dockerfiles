FROM learninglayers/base

RUN apt-get install -y wget \
					   tar \
					   gcc \
					   make \
					   groff \
					   groff-base

WORKDIR /opt
RUN wget ftp://gd.tuwien.ac.at/infosys/network/OpenLDAP/openldap-release/openldap-2.4.40.tgz && \
	mkdir src && \
	mkdir openldap-2.4.40 && \
	tar xfz openldap-2.4.40.tgz -C src/ && \
	cd src/openldap-2.4.40 && \
	./configure --enable-bdb=no --enable-hdb=no && \
	make depend && \
	make && \
	make install

WORKDIR /usr/local/etc/openldap
EXPOSE 389

CMD /usr/local/libexec/slapd && \
    sleep 5 && \ # sleep five seconds to give it enough time to start
    ldapadd -x -w $LDAP_ROOT_PASSWORD -D "cn=LayersManager,dc=layersbox" -f /usr/local/etc/openldap/ldap-init.ldif && \
    pkill slapd && \
    /usr/local/libexec/slapd -d 8 # that's the long-running process
