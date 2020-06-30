# server

A basic system admin project, involving setting up an Nginx web server running several services, using Docker.

## Details

The server runs inside a Docker container, who's image is built from the included Dockerfile.
The container runs Debian Buster, and is based on a LEMP stack (Linux, Nginx, MySQL, PHP).

The Nginx server runs:

  * a basic Wordpress website
  * the PhpMyAdmin service
  * a MariaDB database
  
This is a basic project, and uses localhost, as it is not online.

## Usage

Build the docker image with ```docker build -t <image_name> <path/to/Dockerfile>```.

To run the image, use ```docker run --rm -it -p 127.0.0.1:80:80 -p 127.0.0.1:443:443 <image_name>```.

## Resources

* [Nasm tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
