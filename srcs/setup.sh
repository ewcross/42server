#!/bin/bash

etc/init.d/mysql start
etc/init.d/php7.3-fpm start

# create new database and create user with all privileges on this database
# these details must match those in wp-config file
mysql -e "CREATE DATABASE new_db"
mysql -e "GRANT ALL PRIVILEGES ON new_db.* TO 'new_user'@'localhost' IDENTIFIED BY 'user123'"
# to specify any valid host, replace 'localhost' with '%'

# create sql tables needed by pma user (administartive user within phpmyadmin)
# need to remember where to find these settings - somewhere in the mariadb config files
mariadb < /var/www/localhost/phpmyadmin/sql/create_tables.sql
mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'localhost' IDENTIFIED BY 'lesgobelins'"
mysql -e "FLUSH PRIVILEGES"

# generate self-signed SSL key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=FR/ST=./L=./O=42/CN=localhost" \
# req -x509 - create X.509 certificate and make it self-signed rather than signing request
# -nodes - skip passphrase securing of certificate
# -days 365 - set validity of certificate to 1 year
# -newkey - make key as well as certificate
# rsa:2048 - make this key an rsa key 2048 bytes long
# -keyout - where to put the key
# -out - where to put the certificate
# -subj - specify parameters of subject of key on command line

nginx -g "daemon off;"
