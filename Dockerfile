# Jenkins image for SCA projects
FROM jenkins:latest
MAINTAINER BTower labz@btower.net

LABEL version="1.0"
LABEL description="Jenkins main for SCA project"

#Set user jenkins
USER jenkins

#Configure executors
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

#Configure plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

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
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y make
RUN apt-get install -y ruby
RUN apt-get install -y php
USER jenkins
