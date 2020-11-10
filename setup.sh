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
