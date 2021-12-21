#!/bin/sh

/usr/local/sbin/php-fpm -y /etc/php/php-fpm.conf -g /run/php-fpm.pid --daemonize

exec nginx
