#!/bin/bash

#/etc/init.d/mysql stop

# Install database in directory configured in my.cnf
mysql_install_db

# Restart mysql
/etc/init.d/mysql start

#Get password from config file
MYSQL_PWD_DEBIAN=`grep password /etc/mysql/debian.cnf | cut -d= -f2 | head -n 1 | tr -d ' '`
echo "Password for debian-sys-maint = $MYSQL_PWD_DEBIAN"

# Create debian user
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '$MYSQL_PWD_DEBIAN';"
