FROM ubuntu:16.04

MAINTAINER Cédric Billiet <cedricbilliet@gmail.com>

RUN apt-get -y update && apt-get install -y php
RUN yes | pecl install -o -f xdebug \
          && rm -rf /tmp/pear \
          && echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
          && echo "xdebug.remote_enable=on"  >> /usr/local/etc/php/conf.d/xdebug.ini \
          && echo "xdebug.remote_host=10.1.0.133" >> /usr/local/etc/php/conf.d/xdebug.ini \
          && echo "xdebug.remote_connect_back=On" >> /usr/local/etc/php/conf.d/xdebug.ini \
          && echo "memory_limit = 64M" > /usr/local/etc/php/conf.d/php.ini \
          && echo "xdebug.remote_autostart = 1" >> /usr/local/etc/php/conf.d/xdebug.ini