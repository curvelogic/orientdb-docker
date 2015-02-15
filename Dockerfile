# Dockerfile for an OrientDB 2.0 instance

# debian:jessie based:
FROM java:openjdk-8u40-jdk

MAINTAINER curvelogic "admin@curvelogic.co.uk"

# needs an update to make ant available
RUN apt-get update

RUN apt-get install -y git ant

RUN mkdir /tmp/build 

WORKDIR /tmp/build
RUN git clone https://github.com/orientechnologies/orientdb.git -b 2.0.2

WORKDIR /tmp/build/orientdb
RUN ant clean installg

RUN mv /tmp/build/releases/* /opt 
RUN rm -rf /tmp/build 

WORKDIR /opt/orientdb-community-2.0.2

EXPOSE 2424
EXPOSE 2480

VOLUME ["/opt/orientdb-community-2.0.2/backups"]
VOLUME ["/opt/orientdb-community-2.0.2/config"]
VOLUME ["/opt/orientdb-community-2.0.2/databases"]

# If you don't specify a configuration, on first run set up a root/root user:
ENV ORIENTDB_ROOT_PASSWORD=root

USER root

CMD ["./bin/server.sh"]
