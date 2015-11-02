#!/usr/bin/env bash

#echo "Provisioning virtual machine ..."
#--------------------------------------------------
#               Virtual Machine Setup
#--------------------------------------------------

echo "Updating packages"
yum update

echo  "Installing java 1.6.0_12"

echo "Creating java folders"
mkdir /usr/lib/jvm

echo "Getting java version 1.6.1.0_12"
if [ ! -f /vagrant/install-files/libs/jdk1.6.1.0_12.tar.gz ]; then
    echo "Downloading jboss eap 6.2"
    cd /vagrant/install-files/libs/
    wget --no-check-certificate https://googledrive.com/host/0B3rmATihn6MJV3JQY0JqOVptMkU -O jdk1.6.1.0_12.tar.gz
fi
cd /usr/lib/jvm
tar -zxvf /vagrant/install-files/libs/jdk1.6.1.0_12.tar.gz

echo "Installing java with alternatives "

alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.6.1.0_12/bin/java" 2
alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.6.1.0_12/bin/javac" 2
alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.6.1.0_12/bin/javaws" 2

echo "Creating jboss user"
adduser jboss
passwd -d jboss

adduser user01
passwd -d user01
usermod -a -G jboss user01
usermod -a -G jboss vagrant

echo "Installing jboss"

if [ ! -f /vagrant/install-files/libs/jboss-eap-6.2.tar.gz ]; then
    echo "Downloading jboss eap 6.2"
    cd /vagrant/install-files/libs/
    wget --no-check-certificate https://googledrive.com/host/0B3rmATihn6MJUFR6Z2NYanFsU0k -O jboss-eap-6.2.tar.gz
fi

cd /opt
tar -zxvf /vagrant/install-files/libs/jboss-eap-6.2.tar.gz

chown -R jboss:jboss /opt/jboss-eap-6.2/
ln -s /opt/jboss-eap-6.2/ /opt/jboss
chmod 777 /opt/jboss/bin/standalone.sh
chmod 777 /opt/jboss/bin/jboss-cli.sh
cp /vagrant/install-files/jboss /etc/init.d/

echo "Adding public ip to /etc/hosts"

echo "192.168.1.115   publicip" > /etc/hosts
echo "Allowing trafic for port 8080"
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
/sbin/service iptables save
/sbin/service iptables restart

echo "Copying project installer"
cp /vagrant/install-files/install-src.sh /home/user01/
cp /vagrant/install-files/install-src.sh /home/vagrant/
