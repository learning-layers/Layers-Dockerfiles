FROM learninglayers/base
MAINTAINER Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>

RUN apt-get update -q && apt-get install -yq wget

ADD /src/main/files/initowncloud.sh /opt/initowncloud.sh
RUN chmod +x /opt/initowncloud.sh

CMD /opt/initowncloud.sh
