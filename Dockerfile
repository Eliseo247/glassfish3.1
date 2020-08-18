FROM        java:7-jdk
4
ENV         JAVA_HOME         /usr/lib/jvm/java-7-openjdk-amd64
ENV         GLASSFISH_HOME    /usr/local/glassfish3
ENV         PATH              $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin

RUN         apt-get update && \
            apt-get install -y curl unzip zip inotify-tools && \
            rm -rf /var/lib/apt/lists/*

RUN         curl -L -o /tmp/glassfish-3.1.2.2.zip https://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip && \
            unzip /tmp/glassfish-3.1.2.2.zip -d /usr/local && \
            rm -f /tmp/glassfish-3.1.2.2.zip

EXPOSE      8080 4848 8181

WORKDIR     /usr/local/glassfish3

# verbose causes the process to remain in the foreground so that docker can track it
CMD         asadmin start-domain --verbose
