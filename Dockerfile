# CI master image for SCA projects
FROM jenkins:latest
MAINTAINER BTower labz@btower.net

LABEL version="1.0"
LABEL description="Jenkins main for SCA project"

#Set user jenkins
USER jenkins

#Configure executors
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY sca-admin.groovy /usr/share/jenkins/ref/init.groovy.d/sca-admin.groovy
COPY sca-view.groovy /usr/share/jenkins/ref/init.groovy.d/sca-view.groovy

# Locale fix
RUN /usr/local/bin/install-plugins.sh locale:1.2

# Swarm slaves
RUN /usr/local/bin/install-plugins.sh swarm:3.4

# Workflow
RUN /usr/local/bin/install-plugins.sh workflow-aggregator:2.5

#PHP TOOLS ANALYSERS
RUN /usr/local/bin/install-plugins.sh checkstyle:3.48
RUN /usr/local/bin/install-plugins.sh cloverphp:0.5
RUN /usr/local/bin/install-plugins.sh crap4j:0.9
RUN /usr/local/bin/install-plugins.sh dry:2.47
RUN /usr/local/bin/install-plugins.sh htmlpublisher:1.14
RUN /usr/local/bin/install-plugins.sh jdepend:1.2.4
RUN /usr/local/bin/install-plugins.sh plot:1.11
RUN /usr/local/bin/install-plugins.sh pmd:3.48
RUN /usr/local/bin/install-plugins.sh violations:0.7.11
RUN /usr/local/bin/install-plugins.sh warnings:4.62
RUN /usr/local/bin/install-plugins.sh xunit:1.102
RUN /usr/local/bin/install-plugins.sh git:3.3.2
RUN /usr/local/bin/install-plugins.sh ant:1.5
RUN /usr/local/bin/install-plugins.sh antexec:1.11
RUN /usr/local/bin/install-plugins.sh copy-to-slave:1.44

#Configure logging
COPY log.properties /usr/share/jenkins/log.properties

#TODO: configure ssl
#COPY https.pem /var/lib/jenkins/cert
#COPY https.key /var/lib/jenkins/pk
#ENV JENKINS_OPTS --httpPort=-1 --httpsPort=8083 --httpsCertificate=/var/lib/jenkins/cert --httpsPrivateKey=/var/lib/jenkins/pk

#Expose GUI port
EXPOSE 8080

#Expose slave port
#ENV JENKINS_SLAVE_AGENT_PORT 50000
EXPOSE 50000

#TODO: remove samples, setup footer
#ENV JAVA_OPTS=-Dhudson.footerURL=http://mycompany.com

#Set JAVA environment (logging)
ENV JAVA_OPTS="-Djava.util.logging.config.file=/usr/share/jenkins/log.properties -Djenkins.install.runSetupWizard=false"

#TODO: variuos sca requirements
#Install additional software
USER root
RUN apt-get update && apt-get install -y apt-utils
USER jenkins
