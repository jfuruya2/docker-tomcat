# Use a minimal image as parent
FROM openjdk:8-jdk-alpine

# Environment variables
ENV TOMCAT_MAJOR=9 \
    TOMCAT_VERSION=9.0.76 \
    CATALINA_HOME=/opt/tomcat

# init
RUN apk -U upgrade --update && \
    apk add curl && \
    apk add ttf-dejavu

RUN mkdir -p /opt

# install tomcat
RUN curl -jkSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip /tmp/apache-tomcat.tar.gz && \
    tar -C /opt -xf /tmp/apache-tomcat.tar && \
    ln -s /opt/apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME

COPY server.xml /opt/tomcat/conf/server.xml

# cleanup
RUN apk del curl && \
    rm -rf /tmp/* /var/cache/apk/*

RUN rm -rf $CATALINA_HOME/webapps/*

EXPOSE 8080

EXPOSE 8009

COPY startup.sh /opt/startup.sh

ENTRYPOINT /opt/startup.sh

WORKDIR $CATALINA_HOME
