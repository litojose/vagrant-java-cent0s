#!/usr/bin/env bash

echo "Installing project springmvc"
cp  /vagrant/src/springmvcexample.war /opt/jboss/standalone/deployments/

echo "Restarting jboss"
/etc/init.d/jboss start
