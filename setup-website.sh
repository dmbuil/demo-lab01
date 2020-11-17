#!/bin/bash

# Moves all of the files
cp -r /tmp/dploy/website/*.php /var/www/html/

# Fetch the DB Vales from the ovfEnv
LAB_DATABASE_IP=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.ip' | awk -F\" '{print $4}'`
LAB_DATABASE_FQDN=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.fqdn' | awk -F\" '{print $4}'`
LAB_DATABASE_PASSWD=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.password' | awk -F\" '{print $4}'`
LAB_DATABASE_NAME=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.name' | awk -F\" '{print $4}'`
LAB_DATABASE_USER=`vmtoolsd --cmd "info-get guestinfo.ovfEnv" | grep 'lab.db.user' | awk -F\" '{print $4}'`

# Replace the DB values 
find /var/www/html/*.php -type f -print0 | xargs -0 sed -i "s/{lab.db.ip}/$LAB_DATABASE_IP/g"
find /var/www/html/*.php -type f -print0 | xargs -0 sed -i "s/{lab.db.fqdn}/$LAB_DATABASE_FQDN/g"
find /var/www/html/*.php -type f -print0 | xargs -0 sed -i "s/{lab.db.password}/$LAB_DATABASE_PASSWD/g"
find /var/www/html/*.php -type f -print0 | xargs -0 sed -i "s/{lab.db.name}/$LAB_DATABASE_NAME/g"
find /var/www/html/*.php -type f -print0 | xargs -0 sed -i "s/{lab.db.user}/$LAB_DATABASE_USER/g"

# Change the default PHP file
# pending #
