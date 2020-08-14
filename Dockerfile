FROM        openjdk-8-rhel8:latest

ENV         JAVA_HOME         /usr/lib/jvm/java-1.8.0
ENV         GLASSFISH_HOME    /usr/local/glassfish4
ENV         PATH              $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin

USER root
RUN          dnf install -y curl unzip zip inotify-tools && \
            rm -rf /var/lib/apt/lists/*

RUN         curl -L -o /tmp/glassfish-4.1.zip http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
            unzip /tmp/glassfish-4.1.zip -d /usr/local && \
            rm -f /tmp/glassfish-4.1.zip

EXPOSE      8080 4848 8181

WORKDIR     /usr/local/glassfish4

# verbose causes the process to remain in the foreground so that docker can track it
CMD         asadmin start-domain --verbose
