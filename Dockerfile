FROM ubuntu:16.04

LABEL maintainer="Cédric Billiet <cedricbilliet@gmail.com>"
LABEL maintainer="Sébastien Barbieri <sebastien.barbieri@gmail.com>"
LABEL version="0.1"
LABEL description="Ubuntu 16.04 LTS with php7 & composer + phpunit + code coverage to use with travis and private github repositories"

# to build: docker build -t dockerphp:latest .
# to run: docker run -dit --name="dockerphp" -v /home/travis/build/<travis-clone-folder>:<docker-folder> scips/dockerphp /bin/bash

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && apt-get install -y php7.0 php7.0-dev php7.0-curl php7.0-gd php7.0-json php7.0-mcrypt php7.0-mbstring php-gettext php7.0-mysql php7.0-tidy php7.0-xml php-redis php-soap php-zip git
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php-xdebug wget
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet
RUN mv composer.phar /usr/local/bin/composer

RUN mkdir ~/.ssh
RUN mkdir ~/coverage
