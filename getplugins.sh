#!/usr/bin/env bash

set -o nounset
set -o noclobber
set -o errexit
set -o pipefail

echo "Jenkins plugins setup ..."

# Locale fix
/usr/local/bin/install-plugins.sh locale:1.2

# Swarm plugin is must
/usr/local/bin/install-plugins.sh swarm:3.4

# Workflow plugin is must
/usr/local/bin/install-plugins.sh workflow-aggregator:2.5

# PHP TOOLS
/usr/local/bin/install-plugins.sh checkstyle:3.48
/usr/local/bin/install-plugins.sh cloverphp:0.5
/usr/local/bin/install-plugins.sh crap4j:0.9
/usr/local/bin/install-plugins.sh dry:2.47
/usr/local/bin/install-plugins.sh htmlpublisher:1.14
/usr/local/bin/install-plugins.sh jdepend:1.2.4
/usr/local/bin/install-plugins.sh plot:1.11
/usr/local/bin/install-plugins.sh pmd:3.48
/usr/local/bin/install-plugins.sh violations:0.7.11
/usr/local/bin/install-plugins.sh warnings:4.62
/usr/local/bin/install-plugins.sh xunit:1.102
/usr/local/bin/install-plugins.sh git:3.3.2
/usr/local/bin/install-plugins.sh ant:1.5
/usr/local/bin/install-plugins.sh antexec:1.11
/usr/local/bin/install-plugins.sh ssh-agent:1.15
/usr/local/bin/install-plugins.sh tasks:4.51
/usr/local/bin/install-plugins.sh dependency-check-jenkins-plugin:2.0.1.2
/usr/local/bin/install-plugins.sh clover:4.8.0

# TODO: cleanup tmp files

