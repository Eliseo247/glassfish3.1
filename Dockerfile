FROM registry.redhat.io/rhel7/rhel:latest

#    registry.redhat.io/
USER root

        # Install packages defined in the 'jboss.container.openjdk.jdk' module
        RUN microdnf --setopt=tsflags=nodocs install -y java-1.7.0-openjdk-devel \
            && microdnf clean all \
            && rpm -q java-1.7.0-openjdk-devel
            
            
USER root
RUN chmod 777 /usr/lib/jvm/
ENV         JAVA_HOME         /usr/lib/jvm/java-1.7.0                  
ENV         GLASSFISH_HOME    /usr/local/glassfish3
ENV         PATH              $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin

USER root
RUN          rm -rf /var/lib/apt/lists/*

USER root
RUN         curl -L -o /tmp/glassfish-3.1.2.2.zip  https://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip && \
            unzip /tmp/glassfish-3.1.2.2.zip -d /usr/local && \
             unzip /tmp/glassfish-3.1.2.2.zip -d /opt && \
            rm -f /tmp/glassfish-3.1.2.2.zip


EXPOSE      8080 4848 8181
user root
RUN chmod -R 777 /opt/glassfish3 && \
            chmod -R 777  /usr/local/glassfish3

WORKDIR      /usr/local/glassfish3

# Copy in and set the entrypoint
COPY docker-entrypoint.sh $GLASSFISH_HOME/
user root  
RUN    chmod -R 777  /usr/local/glassfish3/docker-entrypoint.sh

RUN groupadd glassfish_grp && \
useradd --system glassfish && \
usermod -G glassfish_grp glassfish && \ 
chown -R glassfish:glassfish_grp ${GLASSFISH_HOME} && \ 
chmod -R 777 ${GLASSFISH_HOME}
USER glassfish


ENTRYPOINT ["/usr/local/glassfish4/docker-entrypoint.sh"]

# verbose causes the process to remain in the foreground so that docker can track it
CMD         asadmin start-domain --verbose
