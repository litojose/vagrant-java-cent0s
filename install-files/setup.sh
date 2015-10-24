#!/usr/bin/env bash

#echo "Provisioning virtual machine ..."
#--------------------------------------------------
#               Virtual Machine Setup
#--------------------------------------------------

#echo "Creating java folders"
#mkdir /usr/lib/jvm
#mkdir /usr/lib/jvm/jdk1.6.1.0_12

#echo "Getting java version 1.6.1.0_12"
#cp -R /vagrant/install-files/installers/jdk1.6.1.0_12 /usr/lib/jvm/jdk1.6.1.0_12

#echo "Installing java"

#update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.6.1.0_12/bin/java" 1070
#update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.6.1.0_12/bin/javac" 1070
#update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.6.1.0_12/bin/javaws" 1070

echo "Updating packages"
yum update

echo "Installing GIT"
yum install git -y > /dev/null
