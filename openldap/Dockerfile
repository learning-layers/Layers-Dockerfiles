FROM learninglayers/base

RUN apt-get update && apt-get install -y wget \
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
    while ! ping -c1 mysql &>/dev/null; do sleep 0.2; done && \
    while ! timeout 1 bash -c 'cat < /dev/null > /dev/tcp/mysql/3306' 2>/dev/null; do sleep 0.5; done && \
    ldapadd -x -w $LDAP_ROOT_PASSWORD -D "cn=LayersManager,dc=learning-layers,dc=eu" -f /usr/local/etc/openldap/ldap-init.ldif && \
    pkill slapd && \
    /usr/local/libexec/slapd -d 8
