#!/bin/bash

yum update -y

wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm -P /tmp/dploy
rpm -ivh /tmp/dploy/mysql80-community-release-el7-3.noarch.rpm

yum install -y mysql-server

LAB_DATABASE_IP=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.ip' | awk -F\" '{print $4}'`
LAB_DATABASE_FQDN=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.fqdn' | awk -F\" '{print $4}'`
LAB_DATABASE_PASSWD=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.password' | awk -F\" '{print $4}'`
LAB_DATABASE_NAME=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.name' | awk -F\" '{print $4}'`
LAB_DATABASE_USER=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.user' | awk -F\" '{print $4}'`

echo "$LAB_DATABASE_IP -  $LAB_DATABASE_FQDN - $LAB_DATABASE_PASSWD - $LAB_DATABASE_NAME"

systemctl start mysqld

temppasswd=$(grep "temporary password" /var/log/mysqld.log | awk '{print $13}')
mysqladmin -u root -p $temppasswd password $LAB_DATABASE_PASSWD

systemctl restart mysqld
