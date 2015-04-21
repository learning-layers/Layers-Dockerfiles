FROM learninglayers/base

RUN mkir /opt/tomcat/conf
RUN mkir /opt/tomcat/webapps

ADD https://github.com/learning-layers/SocialSemanticServer/releases/download/v9.0.0-alpha/sss.package.tar /opt/sss/

RUN apt-get install -y unzip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/opt/sss/"]
