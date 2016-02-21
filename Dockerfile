FROM unitedasian/php-fpm

MAINTAINER Olivier Pichon <op@united-asian.com>

COPY entrypoint.d /entrypoint.d

ONBUILD COPY . /var/www
