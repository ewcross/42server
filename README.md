# ft_server

A basic system admin project, involving setting up an Nginx web server running several services, using Docker.

## Details

The server runs inside a Docker container, who's image is built from the included Dockerfile.
The container runs Debian Buster, and is based on a LEMP stack (Linux, Nginx, MySQL, PHP).

The Nginx server runs:

  * a basic Wordpress website
  * the PhpMyAdmin service
  * a MariaDB database
  
This project is not online, and uses localhost.

## Usage

Build the docker image with ```docker build -t <image_name> <path/to/Dockerfile>```.

To run the image, use ```docker run --rm -it -p 127.0.0.1:80:80 -p 127.0.0.1:443:443 <image_name>```.

## Resources

* [Dockerfile tutorial](https://takacsmark.com/dockerfile-tutorial-by-example-dockerfile-best-practices-2018/)
* [Installing LEMP stack on Debian 10](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mariadb-php-lemp-stack-on-debian-10)
* [Installing Wordpress with LEMP on Debian 10](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-nginx-mariadb-and-php-on-debian-10)
* [Creating SSL Cert for Nginx](https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-debian-10)
* [Understanding Nginx config file structure](https://www.digitalocean.com/community/tutorials/understanding-the-nginx-configuration-file-structure-and-configuration-contexts)
