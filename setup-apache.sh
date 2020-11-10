#!/bin/bash

#sudo apt-get update -y
#sudo apt-get install apache2 php -y
#sudo apt-get install -y php-{bcmath,bz2,intl,gd,mbstring,mysql,zip} && sudo apt-get install libapache2-mod-php -y

#sudo systemctl enable apache2.service
#sudo systemctl restart apache2.service
yum update
yum install httpd php php-mysql -y
yum install php-{bcmath,bz2,cli,common,dba,devel,intl,gd,mbstring,mysql,zip} && sudo apt-get install libapache2-mod-php -y

systemctl enable httpd.service
systemctl restart httpd.service

LAB_DATABASE_IP=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.ip' | awk -F\" '{print $4}'`
LAB_DATABASE_FQDN=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.fqdn' | awk -F\" '{print $4}'`
LAB_DATABASE_PASSWD=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.password' | awk -F\" '{print $4}'`
LAB_DATABASE_NAME=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.name' | awk -F\" '{print $4}'`
LAB_DATABASE_NAME=`vmtoolsd --cmd "info-get guestInfo.ovfEnv" | grep 'lab.db.user' | awk -F\" '{print $4}'`

echo "DATABASE: $LAB_DATABASE_IP" >> /tmp/dploy.log
echo "DATABASE: $LAB_DATABASE_FQDN" >> /tmp/dploy.log
