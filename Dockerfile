FROM openjdk-8-rhel7:latest

ENV GLASSFISH_HOME /usr/local/glassfish4
ENV PATH $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin

RUN dnf install wget

RUN wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip &&\
         unzip /tmp/glassfish-4.1.zip -d /usr/local && \
         rm -f /tmp/glassfish-4.1.zip

EXPOSE 4848 8080 8181 9009

WORKDIR /usr/local/glassfish4

CMD  asadmin start-domain --verbose
