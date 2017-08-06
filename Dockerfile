# Jenkins CI master image for SCA project.
# TODO: check https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices
# TODO: force en language

FROM jenkins:latest
MAINTAINER BTower labz@btower.net

LABEL Name="docker-sca-ci-master"
LABEL Vendor="btower-labz"
LABEL Version="1.0.0"
LABEL Description="Provides sca ci master"

USER root

#Install additional software
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y apt-utils && rm -rf /var/lib/apt/lists/*
RUN echo 'debconf debconf/frontend select Dialog' | debconf-set-selections

COPY getplugins.sh /tmp/getplugins.sh
RUN chmod ugo+x /tmp/getplugins.sh

USER jenkins

#Configure executors
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY sca-admin.groovy /usr/share/jenkins/ref/init.groovy.d/sca-admin.groovy
COPY sca-view.groovy /usr/share/jenkins/ref/init.groovy.d/sca-view.groovy

# Install plugins
RUN /tmp/getplugins.sh

#Configure logging
COPY log.properties /usr/share/jenkins/log.properties

#TODO: configure ssl
#COPY https.pem /var/lib/jenkins/cert
#COPY https.key /var/lib/jenkins/pk
#ENV JENKINS_OPTS --httpPort=-1 --httpsPort=8083 --httpsCertificate=/var/lib/jenkins/cert --httpsPrivateKey=/var/lib/jenkins/pk

#Expose web port
EXPOSE 8080

#Expose api port
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
