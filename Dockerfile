FROM debian:buster

RUN apt-get update && apt-get install -y \
	vim 

# install nginx
RUN apt-get update && apt-get install -y \
	nginx

# install mariadb
RUN apt-get update && apt-get install -y \
	mariadb-server
	# mariadb is the relevant package referenced by the default-mysql-server metapackage used for debian 10
	# to start mariadb, run command './etc/init.d/mysql start'

# install php packages
RUN apt-get update && apt-get install -y \
	php-fpm \
	php-mysql
	# might not need to start php-fpm, but probably do

RUN mkdir -p var/www/localhost
COPY srcs/index.html var/www/localhost
COPY srcs/info.php var/www/localhost
COPY srcs/localhost etc/nginx/sites-available
RUN ln -s ~/../etc/nginx/sites-available/localhost ~/../etc/nginx/sites-enabled

# install phpmyadmin
RUN apt-get update && apt-get install -y \
	php-mbstring
RUN apt-get update && apt-get install -y \
	wget
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz
RUN tar xf phpMyAdmin-latest-all-languages.tar.gz
RUN rm *tar.gz && mv phpMyAdmin* /var/www/localhost/phpmyadmin

# configure phpmyadmin
RUN mkdir -p /var/lib/phpmyadmin/tmp
COPY srcs/config.inc.php /var/www/localhost/phpmyadmin/
RUN rm var/www/html/index*
COPY srcs/setup.sh . 

# add snippet with certificate and key locations
COPY srcs/self-signed.conf etc/nginx/snippets

# install wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar xzf latest.tar.gz
# try without z (don't think is needed)
RUN rm *tar.gz && mv wordpress /var/www/localhost/
COPY srcs/wp-config.php /var/www/localhost/wordpress

EXPOSE 80
EXPOSE 443

ENTRYPOINT sh setup.sh && bin/bash

# need to run container in background, so either add something
# to setup.sh or use 'tail -f dev/null' or other
