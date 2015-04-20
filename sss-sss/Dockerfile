FROM java:8-jre

MAINTAINER Dieter Theiler "dtheiler@tugraz.at"

RUN mkir /opt/sss/

RUN apt-get -y install mysql-client

EXPOSE 8390

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]