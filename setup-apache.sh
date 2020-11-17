#!/bin/bash

# Installation Process for CentOS

# Installs Apache, PHP and Dependencies
yum update
yum install httpd php php-mysql sed -y
yum install php-{bcmath,bz2,cli,common,dba,devel,intl,gd,mbstring,mysql,zip} && sudo apt-get install libapache2-mod-php -y

systemctl enable httpd.service
systemctl restart httpd.service

LAB_DATABASE_IP=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.ip' | awk -F\" '{print $4}'`
LAB_DATABASE_FQDN=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.fqdn' | awk -F\" '{print $4}'`
LAB_DATABASE_PASSWD=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.password' | awk -F\" '{print $4}'`
LAB_DATABASE_NAME=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.name' | awk -F\" '{print $4}'`
LAB_DATABASE_USER=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.user' | awk -F\" '{print $4}'`

temppasswd=$(grep "temporary password" /var/log/mysqld.log | awk '{print $13}')
mysqladmin -u root -p $temppasswd password $LAB_DATABASE_PASSWD

echo "DATABASE IP: $LAB_DATABASE_IP" >> /tmp/dploy.log
echo "DATABASE FQDN: $LAB_DATABASE_FQDN" >> /tmp/dploy.log
echo "DATABASE User: $LAB_DATABASE_USER" >> /tmp/dploy.log
echo "DATABASE Temp Pass: $temppasswd" >> /tmp/dploy.log

firewall-cmd --add-service=http --permanent
firewall-cmd  --reload

#sed -i "s/{lab.db.fqdn}/$LAB_DATABASE_FQDN/g" /etc/httpd/conf/httpd.conf
