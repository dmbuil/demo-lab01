#!/bin/bash

# Yum Update
yum update -y

# Adds the MySQL Repo
wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm -P /tmp/dploy
rpm -ivh /tmp/dploy/mysql80-community-release-el7-3.noarch.rpm

# Install Requirements
yum install -y expect mysql-server

# Extracts Params from OvfEnv Variables
LAB_DATABASE_IP=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.ip' | awk -F\" '{print $4}'`
LAB_DATABASE_FQDN=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.fqdn' | awk -F\" '{print $4}'`
LAB_DATABASE_PASSWD=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.password' | awk -F\" '{print $4}'`
LAB_DATABASE_NAME=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.name' | awk -F\" '{print $4}'`
LAB_DATABASE_USER=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.user' | awk -F\" '{print $4}'`

echo "$LAB_DATABASE_IP -  $LAB_DATABASE_FQDN - $LAB_DATABASE_PASSWD - $LAB_DATABASE_NAME" >> /tmp/dploy.log

# First Start
systemctl start mysqld

sleep 5

temppasswd=$(grep "temporary password" /var/log/mysqld.log | awk '{print $13}')
echo "TMP Pass: $temppasswd" >> /tmp/dploy.log

systemctl restart mysqld

# Runs the Secure installation

MYSQL_ROOT_TMP_PASS=$temppasswd
MYSQL_ROOT_PASSWORD=$LAB_DATABASE_PASSWD

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect "Enter password for user root:"
send "$MYSQL_ROOT_TMP_PASS\r"

expect "New password:"
send "$MYSQL_ROOT_PASSWORD\r"

expect "Re-enter new password:"
send "$MYSQL_ROOT_PASSWORD\r"

expect "Change the password for root ? ((Press y|Y for Yes, any other key for No) :"
send "n\r"

expect "Remove anonymous users? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Disallow root login remotely? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Remove test database and access to it? (Press y|Y for Yes, any other key for No) :"
send "y\r"

expect "Reload privilege tables now?"
send "y\r"

expect eof
")

echo "$SECURE_MYSQL"
