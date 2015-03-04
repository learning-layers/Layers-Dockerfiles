FROM learninglayers/base

MAINTAINER Petru Nicolaescu

# install mysql client
RUN apt-get -y install mysql-client

# Install build tools
RUN apt-get install -y \
                     wget \
                     unzip \
					 openjdk-7-jre \
                     dos2unix

CMD mkdir /opt
WORKDIR /opt

EXPOSE 8080
